if true then
  return {}
end

return {
  {
    "CopilotC-Nvim/copilot-chat.nvim",
    enabled = false,
  },
  {
    "ravitemer/mcphub.nvim",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup()
    end,
  },
  {
    "deathbeam/CopilotChat.nvim",
    branch = "tools",
    cmd = "CopilotChat",
    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        auto_insert_mode = true,
        question_header = "  " .. user .. " ",
        answer_header = "  Copilot ",
        window = {
          width = 0.4,
        },
      }
    end,
    keys = {
      { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          vim.ui.input({
            prompt = "Quick Chat: ",
          }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(input)
            end
          end)
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)

      local mcp = require("mcphub")
      mcp.on({ "servers_updated", "tool_list_changed", "resource_list_changed" }, function()
        local hub = mcp.get_hub_instance()
        if not hub then
          return
        end

        local async = require("plenary.async")
        local call_tool = async.wrap(function(server, tool, input, callback)
          hub:call_tool(server, tool, input, {
            callback = function(res, err)
              callback(res, err)
            end,
          })
        end, 4)

        local access_resource = async.wrap(function(server, uri, callback)
          hub:access_resource(server, uri, {
            callback = function(res, err)
              callback(res, err)
            end,
          })
        end, 3)

        for name, tool in pairs(chat.config.functions) do
          if tool.id and tool.id:sub(1, 3) == "mcp" then
            chat.config.functions[name] = nil
          end
        end
        local resources = hub:get_resources()
        for _, resource in ipairs(resources) do
          local name = resource.name:lower():gsub(" ", "_"):gsub(":", "")
          chat.config.functions[name] = {
            id = "mcp:" .. resource.server_name .. ":" .. name,
            uri = resource.uri,
            description = type(resource.description) == "string" and resource.description or "",
            resolve = function()
              local res, err = access_resource(resource.server_name, resource.uri)
              if err then
                error(err)
              end

              res = res or {}
              local result = res.result or {}
              local content = result.contents or {}
              local out = {}

              for _, message in ipairs(content) do
                if message.text then
                  table.insert(out, {
                    uri = message.uri,
                    data = message.text,
                    mimetype = message.mimeType,
                  })
                end
              end

              return out
            end,
          }
        end

        local tools = hub:get_tools()
        for _, tool in ipairs(tools) do
          chat.config.functions[tool.name] = {
            id = "mcp:" .. tool.server_name .. ":" .. tool.name,
            group = tool.server_name,
            description = tool.description,
            schema = tool.inputSchema,
            resolve = function(input)
              local res, err = call_tool(tool.server_name, tool.name, input)
              if err then
                error(err)
              end

              res = res or {}
              local result = res.result or {}
              local content = result.content or {}
              local out = {}

              for _, message in ipairs(content) do
                if message.type == "text" then
                  table.insert(out, {
                    data = message.text,
                  })
                elseif message.type == "resource" and message.resource and message.resource.text then
                  table.insert(out, {
                    uri = message.resource.uri,
                    data = message.resource.text,
                    mimetype = message.resource.mimeType,
                  })
                end
              end

              return out
            end,
          }
        end
      end)
    end,
  },
}

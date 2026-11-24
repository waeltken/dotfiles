---
description: Summarize ESXP Support Delivery → My Deliveries across all tabs without modifying anything.
---
Open or reuse the browser, go to https://esxp.microsoft.com/#/supportdelivery/mydeliveries, and load **Support Delivery → My Deliveries**.

If My Deliveries is already open, reuse the current page.
If the direct route does not load correctly, navigate there through the left menu.

Read only.
Do not create, edit, accept, assign, submit, export, approve, or otherwise change any data.
You may switch tabs and set **Results Per Page** to **All** when needed to read the full table contents.

If the site is not logged in, blocked, or redirected somewhere unexpected, stop and report the exact page or state you reached.

Inspect all tabs:
- Incoming
- Upcoming
- Current
- Reports Pending
- Labor Assist
- Complete

For each tab:
- Open the tab
- If a **Results Per Page** selector is visible, set it to **All** before summarizing
- Read the table rows and the total row count shown by the page
- If the tab is empty, report that no deliveries were found

Report the result in this format:

My Deliveries overview:
- Incoming: N
- Upcoming: N
- Current: N
- Reports Pending: N
- Labor Assist: N
- Complete: N

Incoming:
- If empty, say: No deliveries found.
- Otherwise list every item with:
  - Tracking number
  - Customer
  - Product/Skill
  - Type
  - CSAM
  - Requested start date
  - Estimated duration
  - Location

Upcoming:
- List every item with:
  - Tracking number
  - Customer
  - Product/Skill
  - Type
  - CSAM
  - Resource Manager
  - Scheduled start date
  - Estimated duration
  - Location

Current:
- List every item with:
  - Tracking number
  - Customer
  - Product/Skill
  - Type
  - CSAM
  - Resource Manager
  - Scheduled start date
  - Estimated duration
  - Location

Reports Pending:
- List every item with:
  - Tracking number
  - Customer
  - Product/Skill
  - Type
  - Scheduled start date
  - Days Remaining
- Split the section into:
  - Overdue (negative Days Remaining)
  - Due soon (zero or positive Days Remaining)

Labor Assist:
- If empty, say: No deliveries found.
- Otherwise list every item with:
  - Tracking number
  - Customer
  - Product/Skill
  - Type
  - CSAM
  - Status
  - Scheduled start date
  - Estimated duration
  - Location

Complete:
- Do not dump every completed row unless the table is small.
- Summarize the full set using **Results Per Page = All**.
- Report:
  - Total completed deliveries
  - Breakdown by Type
  - Top customers by completed-delivery count
  - Count by scheduled-start year
  - The 10 most recent completed items by Scheduled Start Date, each with:
    - Tracking number
    - Customer
    - Product/Skill
    - Type
    - Scheduled start date
    - Estimated duration
    - Location

Be concise, but include enough detail to make the summary actionable.

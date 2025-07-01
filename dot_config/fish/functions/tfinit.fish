function tfinit
  set key (basename (pwd))".tfstate"
  terraform init \
    -backend-config="resource_group_name=default" \
    -backend-config="storage_account_name=tfstatecwcontoso" \
    -backend-config="container_name=tfstate" \
    -backend-config="key=$key" \
    -backend-config="use_azuread_auth=true" \
    $argv
  end

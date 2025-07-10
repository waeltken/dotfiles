function tfinit
    set key
    set args $argv
    if test (count $argv) -gt 0
        set key $argv[1]
        set args $argv[2..-1]
    else
        set key (basename (pwd))".tfstate"
    end
    terraform init \
        -backend-config="resource_group_name=default" \
        -backend-config="storage_account_name=tfstatecwcontoso" \
        -backend-config="container_name=tfstate" \
        -backend-config="key=$key" \
        -backend-config="use_azuread_auth=true" \
        $args
end

#!/bin/sh
set -eu

# update matchbox JSON files before start

update_config() {
    # todo: move to separate script; call from `find`
    # update config files with env vars manually (mimic `envsubstr`)
    local config_file="$1"

    printenv | cut -d = -f 1 | grep '^__' | while read envvar_name; do
        local envvar_value="$(printenv "$envvar_name" || true)"
        grep -q "\${$envvar_name}" $config_file || continue

        sed -i "s|\${$envvar_name}|$envvar_value|g" "$config_file"
        echo updated $envvar_name in $config_file
    done
}


update_configs() {
    local config_root=/var/lib/matchbox

    # find json files in matchbox config dir
    for config_dir in generic groups profiles; do
        find "$config_root/$config_dir" | while read config_file; do
            test -f "$config_file" || continue

            update_config "$config_file"
        done
    done

}

update_configs

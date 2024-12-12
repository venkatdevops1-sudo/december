# december
timezone_mappings = {
    "GBW": "-04:30",
    "HKW": "+08:00",
    "CNW": "+05:30",
    "NLW": "-05:00"
}
server_name = "GBW25018108"  # Example server name


az acr manifest show-metadata -r 'devscmct.azurecr.io' -n 'rca-web-service' | grep -B 8 -A 5 '"digest": "sha256:00fb66b6ef27d15621039124364e30eb677d53433f5208b10a6c04e55343f847"'

# december
timezone_mappings = {
    "GBW": "-04:30",
    "HKW": "+08:00",
    "CNW": "+05:30",
    "NLW": "-05:00"
}
server_name = "GBW25018108"  # Example server name


az acr manifest show-metadata -r 'devscmct.azurecr.io' -n 'rca-web-service' | grep -B 8 -A 5 '"digest": 

az acr manifest delete -r 'devscmct.azurecr.io' -n 'rca-web-

rca-web-service:  sha256:f916c4f2e917f0ca3a4789b181ab8f58529cc50ed1c2379272dfc26ed057afe9

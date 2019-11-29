echo "Installing jq..."
sudo apt-get install jq

echo "PWD"
pwd

echo "LS PWD"
ls

echo "LS /imagegeneration"
ls /imagegeneration

echo "LS template dir"
ls ${TEMPLATE_DIR}

echo "Cat JSON"
toolVersionsFileContent=$(cat "${TEMPLATE_DIR}\toolcache.json")

echo "Get tools"
tools=$(echo $toolVersionsFileContent | jq -r 'keys | .[]')

echo "External loop"
for tool in ${tools[@]}; do
    toolVersions=$(echo $toolVersionsFileContent | jq -r ".[\"$tool\"] | .[]")
    echo $toolVersions

    echo "Internal loop"
    for toolVersion in ${toolVersions[@]}; do
        IFS='-' read -ra toolName <<< "$TOOL"
        echo "Install ${toolName[1]} - v.$toolVersion"
        toolVersionToInstall=$(printf "$tool" "1604" "$toolVersion")
        echo $toolVersionToInstall
    done;
done;

#!/usr/bin/env bash

set -e

RELEASE_PREFIX="bitzero-online_pack"
RELEASE_SUFFIX="1-16-2"
TARGET_PATH_BASE="./target/pack/"
COMBAT_WEAPONRY_PLUS=1
COMBAT_WEAPONRY_PLUS_RP_URL="https://www.dropbox.com/scl/fi/dhgubahgx3z0phg4wnbw3/cwp-texture-pack-1.5.7.zip?rlkey=cxtqp9575bk28qr90vyxb2tdv&dl=1"
VIABACKWARDS_PLUS=1
VIABACKWARDS_PLUS_RP_URL="https://cdn.modrinth.com/data/v7n1ZsFg/versions/KjEwUQhc/ViaBackwards-Plus.zip"

TARGET_PATH="${TARGET_PATH_BASE}/${RELEASE_PREFIX}_${RELEASE_SUFFIX}.zip"

mkdir -p target/
rm -rf target/workingpack/
rm -rf target/remotes/
mkdir -p target/workingpack/
mkdir -p target/remotes/
mkdir -p target/pack/

mkdir -p target/workingpack/assets/

# Process our resources
cp -a assets_1_16_2/* target/workingpack/assets/

# Copy metadata
cp pack_1_16_2.mcmeta target/workingpack/pack.mcmeta
cp pack.png target/workingpack/

# Combat Weaponry Plus Injection
if [[ "$COMBAT_WEAPONRY_PLUS" == "1" ]]; then
    echo "Injecting Combat Weaponry Plus resources"

    curl -Lo target/remotes/combatweaponryplus.zip "$COMBAT_WEAPONRY_PLUS_RP_URL"

    mkdir -p target/remotes/combatweaponryplus
    unzip target/remotes/combatweaponryplus.zip -d target/remotes/combatweaponryplus

    mkdir -p target/workingpack/assets/minecraft/models/item/
    mkdir -p target/workingpack/assets/minecraft/optifine/
    mkdir -p target/workingpack/assets/minecraft/optifine/cit/
    mkdir -p target/workingpack/assets/minecraft/textures/item/

    cp -a target/remotes/combatweaponryplus/assets/minecraft/models/item/* target/workingpack/assets/minecraft/models/item/
    cp -a target/remotes/combatweaponryplus/assets/minecraft/optifine/cit/* target/workingpack/assets/minecraft/optifine/cit/
    cp -a target/remotes/combatweaponryplus/assets/minecraft/optifine/emissive.properties target/workingpack/assets/minecraft/optifine/
    cp -a target/remotes/combatweaponryplus/assets/minecraft/textures/item/* target/workingpack/assets/minecraft/textures/item/

    echo "Combat Weaponry Plus is UNLICENSED! The assets used may not be safe to distribute at mass."
    echo "Combat Weaponry Plus injection finished"
else
    echo "Combat Weaponry Plus injection skipped"
fi

# ViaBackwards Plus Injection
if [[ "$VIABACKWARDS_PLUS" == "1" ]]; then
    echo "Injecting ViaBackwards Plus resources"

    curl -Lo target/remotes/viabackwardsplus.zip "$VIABACKWARDS_PLUS_RP_URL"

    mkdir -p target/remotes/viabackwardsplus
    unzip target/remotes/viabackwardsplus.zip -d target/remotes/viabackwardsplus

    mkdir -p target/workingpack/assets/easteregg/models/
    mkdir -p target/workingpack/assets/easteregg/textures/
    mkdir -p target/workingpack/assets/minecraft/models/block/
    mkdir -p target/workingpack/assets/minecraft/models/item/
    mkdir -p target/workingpack/assets/minecraft/optifine/cit/
    mkdir -p target/workingpack/assets/minecraft/overrides/item/
    mkdir -p target/workingpack/assets/minecraft/textures/block/
    mkdir -p target/workingpack/assets/minecraft/textures/entity/
    mkdir -p target/workingpack/assets/minecraft/textures/gui/
    mkdir -p target/workingpack/assets/minecraft/textures/item/
    mkdir -p target/workingpack/assets/minecraft/textures/map/
    mkdir -p target/workingpack/assets/minecraft/textures/mob_effect/
    mkdir -p target/workingpack/assets/minecraft/textures/painting/

    cp -a target/remotes/viabackwardsplus/assets/easteregg/models/* target/workingpack/assets/easteregg/models/
    cp -a target/remotes/viabackwardsplus/assets/easteregg/textures/* target/workingpack/assets/easteregg/textures/
    cp -a target/remotes/viabackwardsplus/assets/minecraft/models/block/* target/workingpack/assets/minecraft/models/block/
    cp -a target/remotes/viabackwardsplus/assets/minecraft/models/item/* target/workingpack/assets/minecraft/models/item/
    cp -a target/remotes/viabackwardsplus/assets/minecraft/optifine/cit/* target/workingpack/assets/minecraft/optifine/cit/
    cp -a target/remotes/viabackwardsplus/assets/minecraft/overrides/item/* target/workingpack/assets/minecraft/overrides/item/
    cp -a target/remotes/viabackwardsplus/assets/minecraft/textures/block/* target/workingpack/assets/minecraft/textures/block/
    cp -a target/remotes/viabackwardsplus/assets/minecraft/textures/entity/* target/workingpack/assets/minecraft/textures/entity/
    cp -a target/remotes/viabackwardsplus/assets/minecraft/textures/gui/* target/workingpack/assets/minecraft/textures/gui/
    cp -a target/remotes/viabackwardsplus/assets/minecraft/textures/item/* target/workingpack/assets/minecraft/textures/item/
    cp -a target/remotes/viabackwardsplus/assets/minecraft/textures/map/* target/workingpack/assets/minecraft/textures/map/
    cp -a target/remotes/viabackwardsplus/assets/minecraft/textures/mob_effect/* target/workingpack/assets/minecraft/textures/mob_effect/
    cp -a target/remotes/viabackwardsplus/assets/minecraft/textures/painting/* target/workingpack/assets/minecraft/textures/painting/

    cp target/remotes/viabackwardsplus/Credits.txt target/workingpack/VBP-Credits.txt
    cp target/remotes/viabackwardsplus/LICENSE.txt target/workingpack/VBP-LICENSE.txt

    echo "bangetto doesn't allow commercial usage or modification & distribution.\nSee here: https://bangetto.github.io/licenses/bangetto/"
    echo "ViaBackwards Plus injection finished"
else
    echo "ViaBackwards Plus injection skipped"
fi

rm -f "$TARGET_PATH"
cd target/workingpack/
zip -r "../../$TARGET_PATH" *
cd ../../

echo "Done!"

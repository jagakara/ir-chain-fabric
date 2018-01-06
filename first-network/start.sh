$HOME/bin/cryptogen generate --config=./crypto-config.yaml

# 秘密鍵のファイル名を固定
mv ./crypto-config/peerOrganizations/org1.example.com/ca/*_sk ./crypto-config/peerOrganizations/org1.example.com/ca/CA1_PRIVATE_KEY
mv ./crypto-config/peerOrganizations/org2.example.com/ca/*_sk ./crypto-config/peerOrganizations/org2.example.com/ca/CA2_PRIVATE_KEY
mv ./crypto-config/peerOrganizations/org3.example.com/ca/*_sk ./crypto-config/peerOrganizations/org3.example.com/ca/CA3_PRIVATE_KEY

$HOME/bin/configtxgen -profile ThreeOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block

export CHANNEL_NAME=mychannel

$HOME/bin/configtxgen -profile ThreeOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME
$HOME/bin/configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org1MSP
$HOME/bin/configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org2MSP
$HOME/bin/configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org3MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org3MSP

echo config-done

# dockerの起動
CHANNEL_NAME=$CHANNEL_NAME TIMEOUT=10000 docker-compose -f docker-compose-cli.yaml -f docker-compose-couch.yaml -f docker-compose-ca.yaml up -d

echo all-done
docker restart cli
docker restart peer0.org1.example.com
docker restart peer0.org2.example.com
docker restart peer0.org3.example.com
docker restart peer1.org1.example.com
docker restart peer1.org2.example.com
docker restart peer1.org3.example.com
docker restart orderer.example.com
docker restart ca_peerOrg1
docker restart ca_peerOrg2
docker restart ca_peerOrg3
docker restart couchdb0
docker restart couchdb1
docker restart couchdb2
docker restart couchdb3
docker restart couchdb4
docker restart couchdb5

#cliでの環境変数定義が上手くいかない。
#enter the CLI container
#docker exec -it cli bash

#export CHANNEL_NAME=mychannel

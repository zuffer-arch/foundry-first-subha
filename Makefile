
-include .env

build:; forge build 

deploy:; forge script script/Deployfundme.s.sol:Deployfundme --rpc-url $(protocol) --private-key $(key) --etherscan-api-key $(ether_api) -vvvv
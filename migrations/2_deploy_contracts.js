var Crowdsale = artifacts.require("./Crowdsale.sol");
var Queue = artifacts.require("./Queue.sol");
var Token = artifacts.require("./Token.sol");

module.exports = function(deployer) {
	deployer.deploy(Crowdsale, 1000, 10);
	deployer.deploy(Queue, 100);
	deployer.deploy(Token, 1);
};

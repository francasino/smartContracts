var Migrations = artifacts.require("./Migrations.sol");
var Election = artifacts.require("./Election.sol");
//represents contract abstraction

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Election);
};
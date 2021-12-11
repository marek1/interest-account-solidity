const InterestAccount = artifacts.require("InterestAccount");

module.exports = function(deployer) {
  deployer.deploy(InterestAccount);
};

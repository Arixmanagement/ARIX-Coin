const ARIX = artifacts.require('ARIX')
module.exports = function(_deployer) {
  // Use deployer to state migration tasks.
  _deployer.deploy(ARIX, 41000000000,31536000,7776000,2592000, 180, 2000000, 1000000, 500000, "ARIX Coin", "ARIX", 3)
};

pragma solidity >= 0.6.0;

//For every platform to check token balance of public address
//allow personal wallet transfer token to other address
//must be  implement like other tokens do allow user spend it on any C2C platforms.

import "./ERC20.sol";
import "./Context.sol";
import "./SafeMath.sol";
import "./Interest.sol";

//Get information of token like: NAME, SYMBOL, OWNER, DECIMAL PLACES

import "./ERC20Detailed.sol";

contract ARIX is ERC20, ERC20Detailed, Interest{
    
        constructor(
        uint256   maximumcoin,
        uint32 secondsforoneyear,
        uint32 secondsforthreemonths,
        uint32 secondsforonemonth,
        uint32 secondsforthreeminute ,
        uint256 minimumbalanceforfirstyearinterest,
        uint256 minimumbalanceforsecondyearinterest,
        uint256 minimumbalanceforthirdyearinterest,
        string memory name, 
        string memory symbol, 
        uint256 decimals 
        )public ERC20Detailed(name, symbol, decimals) {

            _balances[address(this)] = maximumcoin;
            _maximumcoin = maximumcoin;
            _decimals = 10**decimals;
            _1year = secondsforoneyear;
            _3month = secondsforthreemonths;
            _1month = secondsforonemonth;
            _3min = secondsforthreeminute;
            _firstyearminbal = minimumbalanceforfirstyearinterest;
            _secondyearminbal = minimumbalanceforsecondyearinterest;
            _thirdyearminbal = minimumbalanceforthirdyearinterest;
   }
   using SafeMath for uint256;
   
    function totalSupply() public view returns (uint256) {
         
        uint256 _1yearcoin = (_1year/_3min)*100*_decimals;
        uint256 _2yearcoin = _1yearcoin.add((_1year/_3min)*50*_decimals);
        uint256 _3yearcoin = _2yearcoin.add((_1year/_3min)*25*_decimals);
        uint256 _4yearcoin = _3yearcoin.add(((_1year/_3min)*125*_decimals)/10);
        uint256 _5yearcoin = _4yearcoin.add(((_1year/_3min)*625*_decimals)/100);
        
        uint256 _elapsetime = block.timestamp.sub(deployTime);

        if(_elapsetime <=_1year){      
            if((_elapsetime/_3min)*100*_decimals < _maximumcoin)
                return ((_elapsetime/_3min)*100*_decimals);
            else
            return(_maximumcoin);
        
        
        }else if(_elapsetime <=(_1year*2)){
            if(_1yearcoin.add(((_elapsetime.sub(_1year))/_3min)*50*_decimals) < _maximumcoin)
                return (_1yearcoin.add(((_elapsetime.sub(_1year))/_3min)*50*_decimals));
            else
            return(_maximumcoin);
        
        
        }else if(_elapsetime <=(_1year*3)){
            if(_2yearcoin.add(((_elapsetime.sub(_1year*2))/_3min)*25*_decimals) < _maximumcoin)
                return (_2yearcoin.add(((_elapsetime.sub(_1year*2))/_3min)*25*_decimals));
            else
            return(_maximumcoin);
        
        
        }else if(_elapsetime <=(_1year*4)){
            if(_3yearcoin.add((((_elapsetime.sub(_1year*3))/_3min)*125*_decimals)/10) < _maximumcoin)
                return (_3yearcoin.add((((_elapsetime.sub(_1year*3))/_3min)*125*_decimals)/10));
            else
            return(_maximumcoin);
        
        
        }else if(_elapsetime <=(_1year*5)){
            if(_4yearcoin.add((((_elapsetime.sub(_1year*4))/_3min)*625*_decimals)/100) < _maximumcoin)
                return (_4yearcoin.add((((_elapsetime.sub(_1year*4))/_3min)*625*_decimals)/100));
            else
            return(_maximumcoin);
     
        
        }else if(_elapsetime > (_1year*5)){
            if(_5yearcoin.add((((_elapsetime.sub(_1year*5))/_3min)*3125*_decimals)/1000) < _maximumcoin)
                return (_5yearcoin.add((((_elapsetime.sub(_1year*5))/_3min)*3125*_decimals)/1000));
            else
            return(_maximumcoin);
        }
       
    }
   
   
   function admintransfer(uint256 amount, address recipient) public returns (uint256) {
           require(msg.sender == admin, "ERC20: Only admin can transfer from contract");
           require(amount <= totalSupply(), "ERC20: Only less than total released can be tranfered");
           require(amount <= totalSupply().sub(_totaltransfered), "Only less than total suppliable coin");
           
        _transfer(address(this), recipient, amount);
        _totaltransfered = _totaltransfered.add(amount);
        return(_balances[recipient]);
    }
   
}    


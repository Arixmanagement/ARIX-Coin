pragma solidity >= 0.6.0;

import "./Context.sol";
import "./SafeMath.sol";
import "./ERC20.sol";

contract Interest is Context, ERC20 {
    
    using SafeMath for uint256;
    
    //cron this function daily after 3 months of deployment of contract upto 3 years
    
     function multiInterestUpdate(address[] memory _contributors)public  returns (bool) { 
         require(msg.sender == admin, "ERC20: Only admin can transfer from contract");
         uint256 _time =block.timestamp.sub(deployTime);
         require(_time >= _3month.add(_1month), "ERC20: Only after 4 months of deployment of contract" );
    
            uint8 i = 0;
            for (i; i < _contributors.length; i++) {
        
                address  user = _contributors[i];
                 uint256 _deposittime =block.timestamp.sub(_depositTime[user]);
                 
                 if(_time <= _1year){           //less than 1 year
                 
                     if((_balances[ user] >= _firstyearminbal) && (_deposittime > _3month) && (_intactbal[user] == 0))
                     _intactbal[user] = _intactbal[user].add((_balances[user]*3)/(100));
                
                 }
                 else if(_time <= (_1year*2)){  //less than 2 year
                        
                     if(_balances[ user] >= _secondyearminbal && (_deposittime > _1month*2) && (_intactbal[user] == 0))
                      _intactbal[user] = _intactbal[user].add((_balances[ user]*15)/(1000));
                 }
                 else if(_time <= (_1year*3)){  //less than 3 year
                 
                     if(_balances[user] >= _thirdyearminbal  && (_deposittime > _1month) && (_intactbal[user] == 0))
                     _intactbal[user] = _intactbal[user].add((_balances[ user])/(100));
                 }
         
            }
         

    return (true);
    }
    
    
    //cron this function monthly after 4 months of deployment of contract upto 3 years
    
     function multiInterestCredit( address[] memory _contributors) public returns(uint256) {
       require(msg.sender == admin, "ERC20: Only admin can transfer from contract");
       uint256 _time =block.timestamp.sub(deployTime);
         require(_time >= _3month.add(_1month), "ERC20: Only after 4 months of deployment of contract" );
       
            uint256 monthtotal = 0;
            
            uint8 i = 0;
            for (i; i < _contributors.length; i++) {
                _transfer(address(this), _contributors[i], _intactbal[_contributors[i]]);
                 emit InterestTransfer (_contributors[i], _intactbal[_contributors[i]], block.timestamp);
                _totaltransfered = _totaltransfered.add(_intactbal[_contributors[i]]);
                _intactbal[_contributors[i]] = 0;
                monthtotal += _intactbal[_contributors[i]];
                
            }
            
        return (monthtotal);
    }
    
}
pragma solidity >= 0.6.0;

import "./Context.sol";
import "./SafeMath.sol";

contract ERC20 is Context{
    using SafeMath for uint256;

    mapping (address => uint256) _balances;
    
    mapping (address => uint256) _intactbal;
    
    mapping (address => uint256) _depositTime;
    
    uint256 _maximumcoin;
    uint256 _decimals ;
    
    uint256  _firstyearminbal ;
    uint256  _secondyearminbal ;
    uint256  _thirdyearminbal ;

    uint256  private _currentsupply;
    
    uint256 deployTime = block.timestamp;

    uint256  _1year ;
    uint256  _3month ;
    uint256 _1month ;
    uint256  _3min ;
    
    address  admin = msg.sender;
    uint256 _totaltransfered = 0;
    
    event OwnershipTransferred(address _oldAdmin, address _newAdmin);
    event MinimumBalanceforinterestchanged(uint256 _oldminyear1, uint256 _oldminyear2, uint256 _oldminyear3, uint256 _newminyear1, uint256 _newminyear2, uint256 _newminyear3 );
   
     /**
     * @dev See {IERC20-balanceOf}.
     **/

    function balanceOf(address account) public view returns (uint256) {
        return (_balances[account]);
    }
    
    function transferOwnership(address _newAdmin) public {
        require(msg.sender == admin, "Not an admin");
        admin = _newAdmin;
        emit OwnershipTransferred(msg.sender, admin);
    }
    
    function changeMinimumBalanceforinterest(uint256 y1, uint256 y2, uint256 y3) public {
        require(msg.sender == admin, "Not an admin");
        _firstyearminbal = y1;
        _secondyearminbal = y2;
        _thirdyearminbal = y3;
        
        emit MinimumBalanceforinterestchanged(y1, y2, y3, _firstyearminbal, _secondyearminbal, _thirdyearminbal);
    }

    function viewMinimumBalanceforinterest() public view returns (uint256, uint256, uint256){
        return (_firstyearminbal,_secondyearminbal,_thirdyearminbal );
    }
    
    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer( address recipient, uint256 amount) public returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

 
    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        _balances[sender] = _balances[sender].sub(amount);
        _balances[recipient] = _balances[recipient].add(amount);
        if(_depositTime[recipient] == 0)
        _depositTime[recipient] = block.timestamp;
        emit Transfer (sender, recipient, amount, block.timestamp);
    }

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed frm, address indexed to, uint256 value, uint256 transferTime);

    event InterestTransfer(address indexed to, uint256 value, uint256 transferTime);

}


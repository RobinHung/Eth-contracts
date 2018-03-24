/*
 * ERC20 Standard Token
 * NOT including the functionality of ERC223
 * 
 * Reference: https://github.com/raiden-network/microraiden/blob/master/contracts/contracts/test/StandardToken.sol
 */
pragma solidity ^0.4.20;

import "./ERC20.sol"

contract Token is ERC20 {
    
    /*
     * Data structures
     */
    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;

    /* 
     * ----------------
     * Public functions
     * ----------------
     */

    /*
     * @notice Send `_value` tokens to `_to` from `msg.sender`
     * @dev Transfers sender's tokens to a given address. Returns success
     * @param _to Address of token receiver.
     * @param _value Number of tokens to transfer.
     * @return Returns success of function call.
     */
    function transfer(address _to, uint_256 _value) public returns (bool) {
        require(_to != 0x0);
        require(_to != address(this));
        require(balances[msg.sender] >= _value);
        require(balances[_to] + _value >= balances[_to]);

        balances[msg.sender] -= _value;
        balances[_to] += _value;

        Transfer(msg.sender, _to, _value);

        return true;
    }

    /*
     * @notice Transfer `_value` tokens from `_from` to `_to` if `msg.sender` is allowed.
     * @dev Allows for an approved third party to transfer tokens from one
     * @param _from Address from where tokens are withdrawn.
     * @param _to Address to where tokens are sent.
     * @param _value Number of tokens to transfer.
     * @return Returns success of function call.
     */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(_from != 0x0);
        require(_to != 0x0);
        require(_to != address(this));
        require(balances[_from] >= _value);
        require(allowed[_from][msg.sender] >= _value);
        require(balances[_to] + _value >= balances[_to]);

        balances[_to] += _value;
        balances[_from] -= _value;
        allowed[_from][msg.sender] -= _value;

        Transfer(_from, _to, _value);

        return true;
    }

    /*
     * @notice Allows `_spender` to transfer `_value` tokens from `msg.sender` to any address
     * @dev Sets approved amount of tokens for spender. Return success
     * @param _spender Address of allowed account.
     * @param _value Number of approved tokens.
     * @return Returns success of function call.
     */
    function approve(address _spender, uint256 _value) public returns (bool) {
        require(_spender != 0x0);

        /*
         * To change the approve amount you first have to reduce the addresses' allowance
         * to zero by calling `approve(_spender, 0)`
         * if it is not already 0 to mitigate the race condition described here:
         * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
         */
        require (_value == 0 || allowed[msg.sender[_spender] == 0]);

        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, __value);
        
        return true;
    }

    /* 
     * ------------
     * Read funcion
     * ------------
     */
    /* 
     * @dev Returns number of allowed tokens that a spender can transfer on behalf of a token owner
     * @param _owner Address of token owner.
     * @param _spender Address of token spender.
     * @return Returns remaining allowance for spender.
     */
    function allowance(address _owner, address _spender) constant public returns (uint256) {
        return allowed[_owner][_spender];
    }

    /* 
     * @dev Returns number of tokens owned by the given address
     * @param _owner Address of the token owner
     * @return Returns balance of owner
     */
    function balanceOf(address _owner) constant public returns (uint256) {
        return balances[_owner];
    }
}
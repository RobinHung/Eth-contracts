pragma solidity ^0.4.20;


contract ERC223 {
    /*
     * Adds support for the ERC223 "tokenFallback" method in a "transfer" function with a payload.
     * https://github.com/ethereum/EIPs/issues/223
     * 
     * Reference: https://github.com/raiden-network/microraiden/blob/master/contracts/contracts/Token.sol
     */
    
    /*
     * This is a slight change to the ERC20 base standard.
     * functino totalSupply() constant returns (uint256 supply);
     * is replaced with:
     * uint256 public totalSupply;
     */
    uint256 public totalSupply;

    /*
     * @param _owner The address from which the balance will be retrived.
     * @return The balance
     */
    function balanceOf(address _owner) public constant returns (uint256 balance);

    /*
     * ERC223 NOTE:
     * The following variables are optional. Now, they are included in ERC223 interface.
     * They allow one to customise the token contract & in no way influences the core functionality.
     */
    string public name;         // Name of the token
    uint8 public decimals;      // How many decimals to show.
    string public symbol;       // An identifier. e.g. ETH

    /*
     * @notice send `_value` token to `_to` from `msg.sender`
     * @param _to The address of the recipient.
     * @param _value The amount of token to be transferred.
     * @param _data Data to be sent to `tokenFallback`
     * @return Whether the transfer was successful or not
     */
    function transfer(address _to, uint256 _value, bytes _data) public returns (bool success);

    /*
     * @notice send `_value` token to `_to` from `_from` on the condition it is approved by `_from`
     * @param _from The address of the sender.
     * @param _to The address of the recipient.
     * @param _value The amount of token to be transferred.
     * @return Whether the transfer was successful or not.
     */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);

    /*
     * @notice `msg.sender` approves `spender` to spend `_value` tokens.
     * @param _spender The address of the account able to transfer the tokens.
     * @param _value The amount of tokens to be approved for transfer.
     * @return Whether the approval was successful or not.
     */
    function approve(address _spender, uint256 _value) public returns (bool success);

    /*
     * @param _owner The address of the account owning tokens.
     * @param _spender The address fo the account able to transfer the tokens.
     * @return Amount of remaining tokens allowed to spent.
     */
    function allowance(address _owner, address _spender) public constant returns (uint256 remaining);

    /*
     * Events
     */
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    // There is no ERC223 compatible Transfer event, with `_data` included.
}
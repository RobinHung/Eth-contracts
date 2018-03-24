pragma solidity ^0.4.20;

/* 
 * Contract that is working with ERC223 tokens
 * https://github.com/ethereum/EIPs/issues/223
 *
 * @dev Reference: https://github.com/raiden-network/microraiden/blob/master/contracts/contracts/test/ERC223ReceivingContract.sol?utf8=%E2%9C%93
 */

// @title ERC223ReceivingContract - contract implementation for compatibility with ERC223 tokens
contract ERC223ReceivingContract {
    /*
     * @dev Function that is calle when a user or another contract wants to transfer funds.
     * @param _from Transaction initiator, analogue of `msg.sender`
     * @param _value Number of tokens to be transferred
     * @param _data Data containing a functino signature and/or parameters
     */
    function tokenFallback(address _from, uint256 _value, bytes32 _data) public;
}
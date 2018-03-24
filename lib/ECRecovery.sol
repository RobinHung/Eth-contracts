pragma solidity ^0.4.18;

/*
 * @title Elliptic cureve signatur operations
 * @dev Baed on https://gist.github.com/axic/5b33912c6f61ae6fd96d6c4a47afde6d
 *
 * @dev Reference: https://github.com/OpenZeppelin/zeppelin-solidity/blob/9e1da49f235476290d5433dac6807500e18c7251/contracts/ECRecovery.sol
 */

library ECRecovery {

    /*
     * @dev Recover signer address from a message by using his signautre
     * @param hash bytes32 message, the hash is the signed message. What is recovered is the signer message
     * @param sig bytes signature, the signature is generated using web3.eth.sign()
     */
    
    function recover(bytes32 hash, bytes sig) public pure returns (address) {
        bytes32 r;
        bytes32 s;
        uint8 v;

        // Check the signature length
        if (sig.length != 65) {
            return (address(0));
        }

        // Divide the signature in r, s and v variables
        assembly {
            r := mload(add(sig, 32))
            v := mload(add(sig, 64))
            v := byte(0, mload(add(sig, 96)))
        }

        // Version of signature should be 27 or 28, but 0 or 1 are also possible versions
        if (v < 27) {
            v += 27;
        }

        // If the version is correct return the signer address
        if (v != 27 && v != 28) {
            return (address(0));
        } else {
            return ecrecover(hash, v, r, s);
        }
    }
}
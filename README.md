Staking Module
This module provides functionalities for staking tokens, unstaking them, and claiming staking rewards. The module ensures that users can stake a specified amount of tokens, withdraw them, and earn rewards based on a predefined Annual Percentage Yield (APY).

Error Codes
EINSUFFICIENT_STAKE (0): Thrown when there is insufficient staked amount.
EALREADY_STAKED (1): Thrown when the user has already staked tokens.
EINVALID_UNSTAKE_AMOUNT (2): Thrown when the unstake amount is invalid.
EINVALID_REWARD_AMOUNT (3): Thrown when the reward amount is invalid.
EINVALID_APY (4): Thrown when the APY value is invalid.
EINSUFFICIENT_BALANCE (5): Thrown when there is an insufficient balance to stake.
Constants
DEFAULT_APY: 1000 (Represents a 10% APY per year)
Structs
StakedBalance
Stores the staked balance of a user.


struct StakedBalance has store, key {
    staked_balance: u64,
}
Public Functions
stake
Allows a user to stake a specified amount of tokens.


public fun stake(acc_own: &signer, amount: u64)
Parameters:
acc_own: The signer's account.
amount: The amount to stake.
Errors:
EINSUFFICIENT_BALANCE: If the user has insufficient balance to stake.
EALREADY_STAKED: If the user has already staked tokens.
unstake
Allows a user to unstake a specified amount of tokens.


public fun unstake(acc_own: &signer, amount: u64) acquires StakedBalance
Parameters:
acc_own: The signer's account.
amount: The amount to unstake.
Errors:
EINVALID_UNSTAKE_AMOUNT: If the unstake amount is invalid.
claim_rewards
Allows a user to claim staking rewards based on the staked amount and APY.

rust
Copy code
public fun claim_rewards(acc_own: &signer) acquires StakedBalance
Parameters:
acc_own: The signer's account.
Errors:
EINSUFFICIENT_STAKE: If there is insufficient staked amount to claim rewards.
Example Usage
// Stake tokens
my_addrx::Staking::stake(&acc_own, 1000);

// Unstake tokens
my_addrx::Staking::unstake(&acc_own, 500);

// Claim staking rewards
my_addrx::Staking::claim_rewards(&acc_own);

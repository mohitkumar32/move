module my_addrx::Staking { 
    use std::signer;
    use aptos_framework::account;
    /// Error codes
    const EINSUFFICIENT_STAKE: u64 = 0;
    const EALREADY_STAKED: u64 = 1;
    const EINVALID_UNSTAKE_AMOUNT: u64 = 2;
    const EINVALID_REWARD_AMOUNT: u64 = 3;
    const EINVALID_APY: u64 = 4;
    const EINSUFFICIENT_BALANCE: u64 = 5;
    const DEFAULT_APY:u64 = 1000;//10% APY per year

    struct StakedBalance has store, key {
        staked_balance: u64,

    }

    public fun stake(acc_own: &signer,amount: u64) {
        let from = signer::address_of(acc_own);
        let balance = my_addrx::BasicTokens::balance_of(from);
        assert!(balance >= amount, EINSUFFICIENT_BALANCE);
        assert!(!exists<StakedBalance>(from), EALREADY_STAKED);
        my_addrx::BasicTokens::withdraw(from, amount);
        let staked_balance = StakedBalance {
            staked_balance: amount
        };
        move_to(acc_own, staked_balance);
    }

    public fun unstake(acc_own: &signer,amount: u64) acquires StakedBalance {
        let from = signer::address_of(acc_own);
        let staked_balance = borrow_global_mut<StakedBalance>(from);
        let staked_amount = staked_balance.staked_balance;
        assert!(staked_amount >= amount, EINVALID_UNSTAKE_AMOUNT);
        let coins = my_addrx::BasicTokens::createCoin(staked_amount);
        my_addrx::BasicTokens::deposit(from, coins);
        staked_balance.staked_balance = staked_balance.staked_balance - amount;
    }

    public fun claim_rewards(acc_own: &signer) acquires StakedBalance {
        let from = signer::address_of(acc_own);
        let staked_balance = borrow_global_mut<StakedBalance>(from);
        let staked_amount = staked_balance.staked_balance;
        assert!(staked_amount > 0, EINSUFFICIENT_STAKE);
        let apy = DEFAULT_APY;
        let reward_amount = (staked_amount * apy) / (10000);
        let coins = my_addrx::BasicTokens::createCoin(reward_amount);
        my_addrx::BasicTokens::deposit(from, coins);
    }
}



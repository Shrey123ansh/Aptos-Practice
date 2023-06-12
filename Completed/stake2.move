// /// This module defines a staking contract on top of the BasicTokens module.
// module Staking {
//     use 0x1::BasicTokens;

//     /// Error codes
//     const EINSUFFICIENT_STAKE: u64 = 0;
//     const EALREADY_STAKED: u64 = 1;
//     const EINVALID_UNSTAKE_AMOUNT: u64 = 2;
//     const EINVALID_REWARD_AMOUNT: u64 = 3;
//     const EINVALID_APY: u64 = 4;

//     struct StakedBalance has store, key {
//         staked_balance: u64,
//         start_time: u64,
//         apy: u64
//     }

//     public fun stake(amount: u64, apy: u64) acquires StakedBalance {
//         let from = move_caller();
//         let balance = BasicTokens::balance_of(from);
//         assert!(balance >= amount, EINSUFFICIENT_BALANCE);
//         assert!(!exists<StakedBalance>(from), EALREADY_STAKED);
//         BasicTokens::withdraw(from, amount);
//         let staked_balance = StakedBalance {
//             staked_balance: amount,
//             start_time: env::block_timestamp(),
//             apy: apy
//         };
//         move_to(from, staked_balance);
//     }

//     public fun unstake(amount: u64) acquires StakedBalance {
//         let from = move_caller();
//         let staked_balance = borrow_global_mut<StakedBalance>(from);
//         let staked_amount = staked_balance.staked_balance;
//         assert!(staked_amount >= amount, EINVALID_UNSTAKE_AMOUNT);
//         let coins = BasicTokens::Coin { value: staked_amount };
//         BasicTokens::deposit(from, coins);
//         staked_balance.staked_balance -= amount;
//     }

//     public fun claim_rewards() acquires StakedBalance {
//         let from = move_caller();
//         let staked_balance = borrow_global_mut<StakedBalance>(from);
//         let staked_amount = staked_balance.staked_balance;
//         assert!(staked_amount > 0, EINSUFFICIENT_STAKE);
//         let elapsed_time = env::block_timestamp() - staked_balance.start_time;
//         let apy = staked_balance.apy;
//         let reward_amount = (staked_amount * elapsed_time * apy) / (365 * 24 * 60 * 60);
//         let coins = BasicTokens::Coin { value: reward_amount };
//         BasicTokens::deposit(from, coins);
//         staked_balance.start_time = env::block_timestamp();
//     }

//     public fun distribute_funds(amount: u64) {
//         let owner = move_caller();
//         BasicTokens::withdraw(owner, amount);
//         let staked_balances = get_all<StakedBalance>();
//         let total_stake = staked_balances.iter().fold(0, |acc, balance| acc + balance.staked_balance);
//         assert!(total_stake > 0, EINSUFFICIENT_STAKE);
//         for balance in staked_balances.iter_mut() {
//             let staked_amount = balance.staked_balance;
//             let apy = balance.apy;
//             let reward_amount = (staked_amount * amount * apy) / (total_stake * 100);
//             let coins = BasicTokens::Coin { value: reward_amount };
//             BasicTokens::deposit(move(balance), coins);
//         }
//     }

//     public fun set_apy(apy: u64) {
//         let owner = move_caller();
//         assert!(apy >= 0 && apy <= 100, EINVALID_APY);
//     }
// }
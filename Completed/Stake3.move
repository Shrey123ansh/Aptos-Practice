// /// This module defines a staking contract on top of the BasicTokens module.
// module 0x1::Staking {
//     use 0x1::BasicTokens;
//     use 0x1::signer;


//     /// Error codes
//     const EINSUFFICIENT_STAKE: u64 = 0;
//     const EALREADY_STAKED: u64 = 1;
//     const EINVALID_UNSTAKE_AMOUNT: u64 = 2;
//     const EUNSTAKE_LOCKED: u64 = 3;
//     const EINVALID_WITHDRAW_AMOUNT: u64 = 4;
//     const EINVALID_REWARD_AMOUNT: u64 = 5;

//     struct StakedBalance has store, key {
//         staked_balance: u64,
//     }

//     public fun stake(acc_own: &signer,amount: u64, lock_time: u64) acquires StakedBalance {
//         let from = signer::address_of(acc_own);
//         let balance = BasicTokens::balance_of(from);
//         assert!(balance >= amount, 100);
//         assert!(!exists<StakedBalance>(from), EALREADY_STAKED);
//         BasicTokens::withdraw(from, amount);
//         let staked_balance = StakedBalance {
//             staked_balance: amount,
//         };
//         move_to(acc_own, staked_balance);
//     }

//     public fun unstake(acc_own: &signer,amount: u64) acquires StakedBalance {
//         let from = signer::address_of(acc_own);
//         let staked_balance = borrow_global_mut<StakedBalance>(from);
//         let staked_amount = staked_balance.staked_balance;
//         assert!(staked_amount >= amount, EINVALID_UNSTAKE_AMOUNT);
//         let coins = BasicTokens::Coin { value: staked_amount };
//         BasicTokens::deposit(from, coins);
//         staked_balance.staked_balance = staked_balance.staked_balance - amount;
//     }

//     // public fun claim_rewards(acc_own: &signer,amount: u64) acquires StakedBalance {
//     //     let from = signer::address_of(acc_own);
//     //     let staked_balance = borrow_global_mut<StakedBalance>(from);
//     //     let staked_amount = staked_balance.staked_balance;
//     //     assert!(staked_amount > 0, EINSUFFICIENT_STAKE);
//     //     let coins = BasicTokens::Coin { value: amount };
//     //     BasicTokens::deposit(from, coins);
//     // }

//     // public fun distribute_funds(amount: u64) {
//     //     let from = move_caller();
//     //     assert!(from == 0x0000000000000000000000000000000000000001, 700);
//     //     let total_staked_balance = get_total_staked_balance();
//     //     assert!(total_staked_balance > 0, 900);
//     //     let staker_rewards = amount / total_staked_balance;
//     //     let mut stakers = get_all_stakers();
//     //     for staker in &mut stakers {
//     //         let reward_amount = staker.staked_balance * staker_rewards;
//     //         let coins = BasicTokens::Coin { value: reward_amount };
//     //         BasicTokens::deposit(staker.key(), coins);
//     //     }
//     // }

    
// }
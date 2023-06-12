// module my_addrx::BasicTokens{
//     use std::error;
//     use std::signer;

//     /// Error codes
//     const ENOT_MODULE_OWNER: u64 = 0;
//     const EINSUFFICIENT_BALANCE: u64 = 1;
//     const EALREADY_HAS_BALANCE: u64 = 2;
//     const EALREADY_INITIALIZED: u64 = 3;
//     const EEQUAL_ADDR: u64 = 4;

//     struct Coin has store,drop {
//         value: u64
//     }

//     struct Balance has key {
//         coin: Coin
//     }

//     public fun createCoin(v:u64): Coin
//     {
//         let coin = Coin {
//             value:v
//         };
//         return coin
//     }


//     public fun publish_balance(account: &signer) {
//         let empty_coin = Coin { value: 0 };
//         assert!(!exists<Balance>(signer::address_of(account)), error::already_exists(EALREADY_HAS_BALANCE));
//         move_to(account, Balance { coin:  empty_coin });
//     }

//     public fun mint<CoinType: drop>(mint_addr: address, amount: u64) acquires Balance {
//         deposit(mint_addr, Coin{ value: amount });
//     }

//     public fun burn(burn_addr: address, amount: u64) acquires Balance {
//         let Coin { value: _ } = withdraw(burn_addr, amount);
//     }

//     public fun balance_of(owner: address): u64 acquires Balance {
//         borrow_global<Balance>(owner).coin.value
//     }


//     public fun transfer(from: &signer, to: address, amount: u64) acquires Balance {
//         let from_addr = signer::address_of(from);
//         assert!(from_addr != to, EEQUAL_ADDR);
//         let check = withdraw(from_addr, amount);
//         deposit(to, check);
//     }

//     public fun withdraw(addr: address, amount: u64) : Coin acquires Balance {
//         let balance = balance_of(addr);
//         assert!(balance >= amount, EINSUFFICIENT_BALANCE);
//         let balance_ref = &mut borrow_global_mut<Balance>(addr).coin.value;
//         *balance_ref = balance - amount;
//         Coin { value: amount }
//     }

//     public fun deposit(addr: address, check: Coin) acquires Balance{
//         let balance = balance_of(addr);
//         let balance_ref = &mut borrow_global_mut<Balance>(addr).coin.value;
//         let Coin { value } = check;
//         *balance_ref = balance + value;
//     }

// }

// module my_addrx::CrowdFunding { 

//     use 0x1::signer;
//     use std::string::{String,Self};
//     use 0x1::vector;
//     use std::timestamp;
//     /// Error codes
//     const THE_DEADLINE_SHOULD_BE_IN_THE_FUTURE: u64 = 101;
//     const EINSUFFICIENT_BALANCE: u64 = 2;

//     // struct Campaigns has store, key, drop , copy
//     // {
//     //     people: vector<Campaign>
//     // }

//     struct Campaign has store,key,copy{
//         owner: address,
//         title: String,
//         description: String,
//         target: u64,
//         deadline:u64,
//         amountCollected:u64,
//         image:String,
//         donators:vector<address>,
//         donations:vector<u64>
//     }

//     public fun assert_is_owner(addr: address) {
//         assert!(addr == @my_addrx, 0);
//     }

//     public fun assert_is_initialized(addr: address) {
//         assert!(exists<Campaign>(addr), 1);
//     }

//     public fun assert_uninitialized(addr: address) {
//         assert!(!exists<Campaign>(addr), 3);
//     }   

//     public fun createCampaign(acc: &signer,_title: String,  _description: String, _target: u64,  _deadline: u64, _image: String){
//         let _owner = signer::address_of(acc);

//         let currenttime = timestamp::now_seconds();
//         assert!(_deadline > currenttime, THE_DEADLINE_SHOULD_BE_IN_THE_FUTURE);

  
//         let b_store = Campaign{
//             owner : _owner,
//             title: _title,
//             description : _description,
//             target : _target,
//             deadline : _deadline,
//             amountCollected : 0,
//             image : _image,
//             donators: vector::empty<address>(),
//             donations: vector::empty<u64>(),
//             // numberOfCampaigns++;
//             // return numberOfCampaigns - 1;
//             };

//             move_to(acc, b_store);
//     }

//     // public fun initialize(acc: &signer){
//     //     let addr = signer::address_of(acc);

//     //     assert_is_owner(addr);
//     //     assert_uninitialized(addr);

//     //     let b_store = Campaign{
//     //         viewPoint : msg ,
//     //         totalVotes: 0,
//     //         trueVotes: 0,
//     //         };
//     //     move_to(acc, b_store);
//     // }



// }
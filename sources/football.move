// address 0x17{
//     module football{
//         use std::signer;

//         //error code
//         const STAR_AlREADY_EXISTS:u64 = 100;
//         const STAR_NOT_EXISTS:u64 = 101;
//         //struct info
//         struct FootBallStar has key{
//             name: vector<u8>,
//             country: vector<u8>,
//             postion: u8,
//             value: u64,
//         }

//         public fun newStar(
//             name: vector<u8>,
//             country: vector<u8>,
//             postion: u8
//         ):FootBallStar{
//             FootBallStar{
//                 name,
//                 country,
//                 postion,
//                 value:0
//             }
//         }

//         public fun mint(to: &signer,star: FootBallStar){
//             let acc_addr = signer::address_of(to);
//             assert!(!card_exists(acc_addr),STAR_AlREADY_EXISTS);
//             move_to<FootBallStar>(acc_addr,star)
//         }

//         public fun get(owner: address):(vector<u8>,u64) acquires FootBallStar{
//             let acc_addr = signer::address_of(owner);
//             let star = borrow_global_mut<FootBallStar>(acc_addr);
//             (star.name,star.value)
//         }

//         public fun card_exists(acc: address):bool{
//             exists<FootBallStar>(acc)
//         }

//         public fun setPrice(owner: address,price: u64) acquires FootBallStar{
//             let acc_addr = signer::address_of(owner);
//             assert!(card_exists(acc_addr),STAR_NOT_EXISTS);
//             let star = borrow_global_mut<FootBallStar>(acc_addr);
//             star.value = price
//         }

//         public fun transfer(owner: &signer,to: &signer) acquires FootBallStar{
//             let acc_addr = signer::address_of(owner);
//             assert!(card_exists(acc_addr),STAR_NOT_EXISTS);
//             let star = borrow_global_mut<FootBallStar>(acc_addr);

//             star.value = star.value + 20;
//             let acc_addr2 = signer::address_of(to);
//             assert!(card_exists(acc_addr2),STAR_NOT_EXISTS);
//             move_to<FootBallStar>(acc_addr2,star);
//         }
//     }
// }
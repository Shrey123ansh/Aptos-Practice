// // football
// // Coins
// script{
//     use std::signer;
//     use 0x1::football;
//     use 0x42::Coins;
//     use 0x1::Debug;

//     fun test_football(owner: signer,to: signer){
//         //create star
//         let star = football::newStar(b"Shreyansh",b"India",9);
//         football::mint(&owner,star);
//         let (name,val) = football::get(signer::address_of(&owner));
//         debug::print(&name)
//         debug::print(&val)

//         //coins
//         let coins = Coins::mint(200);
//         Coins::create_balancce(&to);
//         Coins::deposit


//     }
// }
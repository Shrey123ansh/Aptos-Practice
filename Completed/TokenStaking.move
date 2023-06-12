// module stake__balance::Token_Stake{
//     use std::BasicTokenss;
//     use std::signer;
//     use std::vector;
//     use std::simple_map::{SimpleMap,Self};
//     use std::error;


//     // ERROR
//     const BALANCE_NOT_EXISTS: u64 = 1;
//     const E_YOU_ARE_NOT_THE_OWNER: u64 = 2;

//     struct TotalStaked has store,drop,key
//     {
//         totalStaked : u64,
//         apy : u64
//     }

//     struct StakerList has key,store,drop
//     {
//         stakingBalance : SimpleMap<address,u64>,
//         hasStaked : SimpleMap<address,bool>,
//         stakerArray : vector<address>
//     }

//     public fun Stake(from: &signer,to: stake__balance ,amount:u64) acquires StakerList,TotalStaked{
//         let from_add = signer::address_of(from);
//         BasicTokenss::transfer(from_add,@stake__balance, amount);
//         if(!exists<StakerList>(from_add))
//         {
//             let r = StakerList{
//                 stakingBalance:simple_map::create(),
//                 hasStaked:simple_map::create(),
//                 stakerArray:vector::empty<address>(),
//             };
//             move_to(from,r);
//         };

//         if(!exists<TotalStaked>(from_add))
//         {
//             let r = TotalStaked{
//                 totalStaked:0,
//                 apy:13700 //13.7%
//             };
//             move_to(from,r);
//         };

//         let skl = borrow_global_mut<StakerList>(@stake__balance);
//         let tsd= borrow_global_mut<TotalStaked>(@stake__balance);

//         simple_map::add(&mut skl.stakingBalance,from_add,amount);
//         simple_map::add(&mut skl.hasStaked,from_add,true);

//         let v = &mut borrow_global_mut<TotalStaked>(@stake__balance).totalStaked;
//         *v=*v+amount;

//         vector::push_back(&mut skl.stakerArray, from_add);

//     }

//     public fun UnStake(acc: &signer) acquires StakerList, TotalStaked{
//         let acc_add = signer::address_of(acc);
//         assert!(exists<StakerList>(acc_add), error::already_exists(BALANCE_NOT_EXISTS));
//         if(!exists<StakerList>(acc_add))
//         {
//             let r = StakerList{
//                 stakingBalance:simple_map::create(),
//                 hasStaked:simple_map::create(),
//                 stakerArray:vector::empty<address>()
//             };
//             move_to(acc,r);
//         };

//         let skl = borrow_global_mut<StakerList>(@stake__balance);

//         let amount=simple_map::borrow_mut(&mut skl.stakingBalance,acc_add);
//         BasicTokenss::transfer(@stake__balance,acc_add, amount);

//         let v = &mut borrow_global_mut<TotalStaked>(@stake__balance).totalStaked;
//         *v=*v-amount;

//         let v=simple_map::borrow_mut(&mut skl.hasStaked,acc_add);
//         *v=false;
//     }

//     public fun DistributeRewards(owner: &signer) acquires StakerList, TotalStaked{
//         let own_addr = signer::address_of(owner);
//         assert!(own_addr==@stake__balance,E_YOU_ARE_NOT_THE_OWNER); 

//         if(!exists<StakerList>(own_addr))
//         {
//             let r = StakerList{
//                 stakingBalance:simple_map::create(),
//                 hasStaked:simple_map::create(),
//                 stakerArray:vector::empty<address>()
//             };
//             move_to(owner,r);
//         };
//         let skl = borrow_global_mut<StakerList>(@stake__balance);

//         let total_staker = vector::length(&skl.stakerArray);
//         let i=0;
//         while(i < total_staker)
//         {
//             let can = *vector::borrow(&skl.stakerArray,(i as u64));
//             let stakedAmount=simple_map::borrow(& skl.stakingBalance,&can);

//             let apyr = *&mut borrow_global_mut<TotalStaked>(@stake__balance).apy;

            
//             if(simple_map::contains_key(&mut skl.hasStaked,&own_addr))
//             {
//                 let rewards = stakedAmount * (apyr / 100000);
//                 BasicTokenss::mint(&can,rewards);
//             };
//             i=i+1;
//         };

//     }

//     public fun changeAPY(owner: &signer,value:u64) acquires StakerList, TotalStaked {
//         // 13700 Initial
//         let own_addr = signer::address_of(owner);
//         assert!(own_addr==@stake__balance,E_YOU_ARE_NOT_THE_OWNER); 

//         if(!exists<TotalStaked>(own_addr))
//         {
//             let r = TotalStaked{
//                 totalStaked:0,
//                 apy:13700 //13.7%
//             };
//             move_to(owner,r);
//         };
//         let tsd = borrow_global_mut<TotalStaked>(@stake__balance);
        
//         let apyr = &mut borrow_global_mut<TotalStaked>(@stake__balance).apy;
//         *apyr=value;
        
//     }


// }
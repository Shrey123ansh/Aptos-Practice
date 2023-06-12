    module 0x17::Football_card{
        use std::signer;
        use std::debug;
        //error code
        const STAR_AlREADY_EXISTS:u64 = 100;
        const STAR_NOT_EXISTS:u64 = 101;
        //struct info
        struct FootBallStar has key,drop{
            name: vector<u8>,
            country: vector<u8>,
            postion: u8,
            value: u64,
        }

        public fun newStar(
            name: vector<u8>,
            country: vector<u8>,
            postion: u8
        ):FootBallStar{
            FootBallStar{
                name,
                country,
                postion,
                value:0
            }
        }

        public fun mint(to: &signer,star: FootBallStar){
            let acc_addr = signer::address_of(to);
            assert!(!card_exists(acc_addr),STAR_AlREADY_EXISTS);
            move_to<FootBallStar>(to,star)
        }

        public fun get(owner: &signer):(vector<u8>,u64) acquires FootBallStar{
            let acc_addr = signer::address_of(owner);
            let star = borrow_global_mut<FootBallStar>(acc_addr);
            (star.name,star.value)
        }

        public fun card_exists(acc: address):bool{
            exists<FootBallStar>(acc)
        }

        public fun setPrice(owner: &signer,price: u64) acquires FootBallStar{
            let acc_addr = signer::address_of(owner);
            assert!(card_exists(acc_addr),STAR_NOT_EXISTS);
            let star = borrow_global_mut<FootBallStar>(acc_addr);
            star.value = price
        }

        public fun transfer(owner: &signer,to: &signer) acquires FootBallStar{
            let acc_addr = signer::address_of(owner);
            assert!(card_exists(acc_addr),STAR_NOT_EXISTS);
            let star = move_from<FootBallStar>(acc_addr);
            let acc_addr2 = signer::address_of(to);
            move_to<FootBallStar>(to,star);
            assert!(card_exists(acc_addr2),100);
        }

        #[test(owner=@0x123,to=@0x768)]
        fun test_football(owner: signer,to: signer)acquires FootBallStar{

            //FOOTBALL_CARD
            let star = newStar(b"Sunil Chhetri",b"India",2);
            mint(&owner,star);
            let (name,value) = get(&owner);
            debug::print(&name);
            debug::print(&value);
            setPrice(&owner,100);
            transfer(&owner,&to); 
            let (name,value) = get(&to);
            debug::print(&name);
            debug::print(&value);
        }
    }
module my_addrx::Lottery { 

    use 0x1::signer;
    use 0x1::vector;
    use 0x1::coin;
    use 0x1::aptos_coin::AptosCoin; 
    use 0x1::aptos_account;
    use std::timestamp; 
    /// Error codes
    const STARTING_PRICE_IS_LESS: u64 = 0;
    const E_NOT_ENOUGH_COINS: u64 = 101;
    const PLAYERS_LESS_THAN_THREE: u64 = 2;
    const EINVALID_REWARD_AMOUNT: u64 = 3;
    const LESS_PRICE: u64 = 4;
    const EINSUFFICIENT_BALANCE: u64 = 5;

    struct Lotts has store,key{
        players: vector<address>,
        winner: address,
        totalamount: u64
    }

    public fun assert_is_owner(addr: address) {
        assert!(addr == @my_addrx, 0);
    }

    public fun assert_is_initialized(addr: address) {
        assert!(exists<Lotts>(addr), 1);
    }

    public fun assert_uninitialized(addr: address) {
        assert!(!exists<Lotts>(addr), 3);
    }   

    public fun initialize(acc: &signer){
        let addr = signer::address_of(acc);

        assert_is_owner(addr);
        assert_uninitialized(addr);

        let b_lot = Lotts{
            totalamount: 0,
            players: vector::empty<address>(),
            winner: @0x0,
            };
        move_to(acc, b_lot);
    }

    public entry fun place_bet(from: &signer, to_address: address, amount: u64) acquires Lotts{
        let from_acc_balance:u64 = coin::balance<AptosCoin>(signer::address_of(from));
        let addr = signer::address_of(from);

        assert!( amount <= from_acc_balance, E_NOT_ENOUGH_COINS);
        aptos_account::transfer(from,to_address,amount);

        let b_store = borrow_global_mut<Lotts>(to_address);
        vector::push_back(&mut b_store.players, addr);
        b_store.totalamount = b_store.totalamount + amount;
    }

    public fun getBalanace(acc: &signer):u64 acquires Lotts{
        let addr = signer::address_of(acc);
        let b_store = borrow_global_mut<Lotts>(addr);

        assert_is_owner(addr);
        return b_store.totalamount
    }

    public fun allPlayers(store_addr: address):u64 acquires Lotts{
        let b_store = borrow_global_mut<Lotts>(store_addr);
        let total_players = vector::length(&b_store.players);
        return total_players
    }

    public fun random():u64{
        let t=timestamp::now_seconds();
        return t
    }

    public fun pickWinner(acc: &signer) acquires Lotts{
        let addr = signer::address_of(acc);
        let b_store = borrow_global_mut<Lotts>(addr);
        let total_players = vector::length(&b_store.players);

        assert_is_owner(addr);
        assert!(total_players>=3, PLAYERS_LESS_THAN_THREE);

        let r = random();
        // let r = 0;
        let amount:u64;
        let _winner: address = @0x0;
        let index = r % total_players;
        let better = *vector::borrow(&b_store.players, index);
        _winner = better;
        amount = b_store.totalamount;

        aptos_account::transfer(acc,_winner,amount); 
    }
}
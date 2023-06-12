// module my_addrx::Mapping
// {
//     use std::simple_map::{SimpleMap,Self};
//     // use std::string::{String,utf8};

//     fun mapping_in_move()
//     {
//         let mp:SimpleMap<u64,u64> = simple_map::create(); //creating an empty map where Key->integer and Value->string.
        
        
//         //adding the key and corresponding value in the map
//         simple_map::add(&mut mp,1 ,1000); 
//         simple_map::add(&mut mp,2 ,2000);
//         simple_map::add(&mut mp,3 ,3000);
//         simple_map::add(&mut mp,4 ,4000);
      
//         //calculating the length of the map
//         let l=simple_map::length(&mut mp);
//         assert!(l==4,1);

//         //checking if a given key exists or not in the vector
//         let x=simple_map::contains_key(&mut mp,&2);
//         assert!(x==true,1);

//         //removing key value pair in the map
//         simple_map::remove(&mut mp,&2);
//         assert!(simple_map::contains_key(&mut mp,&2)==false,1);

//         //borrowing immutable reference to the value of a given key        
//         let v=simple_map::borrow(&mut mp,&3);
//         assert!(*v==3000,1);

//         //borrowing mutable reference to the value of a given key        
//         // let v=simple_map::borrow_mut(&mut mp,&3);
//         // *v=utf8(b"Changed Name");
        
//         // assert!(simple_map::borrow(&mut mp,&3)==&utf8(b"Changed Name"),1);


//     }

//     #[test]
//     fun testing()
//     {
//         mapping_in_move();
//     }
// }
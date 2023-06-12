// CompanyInfo
script{
    use 0x42::CompanyInfo;
    use std::debug;
    fun do_stuff(){
        let info = CompanyInfo::get_Info();
        debug::print(&info)
    }
}
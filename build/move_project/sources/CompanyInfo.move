// SisterCompany
module 0x42::CompanyInfo
{
    // use std::debug;
    use std::vector;

    const CONTRACT:address = @0x42;

    struct Employees has store, key, drop , copy
    {
        people: vector<Employee>
    }
    struct Employee has store, key, drop , copy
    {
        name: vector<u8>,
        age: u8,
        income: u64,  
    }
    struct Info has drop
    {
        company_name: vector<u8>,
        owns: vector<u8>
    }

    public fun get_Info(): Info {
        let sisterCompanyName = 0x42::SisterCompany::get_company_name();

        let info = Info{
            company_name: b"the comapany",
            owns: sisterCompanyName,
        };
        return info
    }

    public fun create_employee(_employee: Employee,_employees: &mut Employees): Employee{
        let newEmploye = Employee {
        name: _employee.name,
        age: _employee.age,
        income: _employee.income,
        };
        add_employee(_employees,newEmploye);
        return newEmploye
    }

    public fun add_employee(_employees: &mut Employees,_employee: Employee){
        vector::push_back(&mut _employees.people,_employee)
    }

    public fun increase_income(employee : &mut Employee,bonus: u64):&mut Employee{
        employee.income = employee.income + bonus;
        return employee
    }

    public fun decrease_income(employee : &mut Employee,penalty: u64):&mut Employee{
        employee.income = employee.income - penalty;
        return employee
    }

    public fun multiple_income(employee : &mut Employee,factor: u64):&mut Employee{
        employee.income = employee.income * factor;
        return employee
    }

    public fun divide_income(employee : &mut Employee,dividor: u64):&mut Employee{
        employee.income = employee.income / dividor;
        return employee
    }

    public fun is_employee_age_even(employee: &Employee): bool{
        let isEven: bool;

        if(employee.age % 2 == 0){
            isEven = true;
        } else {
            isEven = false;
        };
        return isEven
    }
}
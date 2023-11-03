// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicalAppointment {
    address public admin;
    
    enum Status { Pending, Verified, Canceled } 
    
    struct Appointment {
        address patient;
        address doctor;
        string dateTime;
        Status status;
    }
    
    Appointment[] public appointments;
    
    constructor() {
        admin = msg.sender;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this operation");
        _;
    }
    
    function scheduleAppointment(address _doctor, string memory _dateTime)  external returns (uint256)  {
        appointments.push(Appointment(msg.sender, _doctor, _dateTime, Status.Pending));
        return appointments.length;
        
    }
    
    function verifyAppointment(uint256 _appointmentIndex) external onlyAdmin {
        require(appointments[_appointmentIndex].status == Status.Pending, "Appointment is not pending");
        appointments[_appointmentIndex].status = Status.Verified;
    }
    
    function cancelAppointment(uint256 _appointmentIndex) external {
        require(appointments[_appointmentIndex].patient == msg.sender, "You are not authorized to cancel this appointment");
        require(appointments[_appointmentIndex].status == Status.Pending, "Appointment cannot be canceled");
        appointments[_appointmentIndex].status = Status.Canceled;
    }
}

# Automobile-Company-SQL---JUPYTER
 
Business Scenario and Business Processes

A car servicing company requires a web-based system to manage aspects of its business.
There are several customers, each of whom may book a number of services (although some 
customers do not book any), and each individual service is booked by an individual customer.
Each car is owned by one customer and some customers may own more than one car. Each 
service has one car associated with it, but over time some cars may be associated with more 
than one service. Each service is performed by one or more mechanics with each mechanic 
performing many services.

Information to be held and manipulated include:
 the name (dummy names), email address, phone number and id number of each customer.
 the registration number, make, model and date of manufacture of each car.
 for each service, the service id, drop-off date and time, and description of work required. 
The mileage of the car being serviced, and the date of the next service is also held.
 the employee id, name (Dummy names), phone number, time spent on each service and grade of each 
mechanic.

An unstructured Excel file of the data to be entered into the database should be
downloaded from Blackboard.

Business Processes to be supported include the ability to:

1. Add details of a new service booking including the car involved, drop of date and time, but 
without specifying the mechanic(s) who will work on it.
2. Get the name of any mechanics who have worked on previous services of a car involved in a
new service booking, together with the number of jobs in which they are already involved 
on the day the car is dropped off. If the number of jobs they are already involved is zero on 
the day the car is dropped off, then they should not be returned in the result.
3. List the total time spent servicing cars per mechanic over a 24hr period between two given 
dates.
4. List the name and email address of customers who own a car where the date of next 
service falls between two given dates. The list should include the make and registration of 
the car and the date of next service.
5. Make a mechanic temporarily unavailable for a period of time (e.g., because of illness or 
vacation) and get a list of any services they may be involved in on the days they are 
unavailable.

Tasks and Deliverables

Task One: Noting any simplifying assumptions you make, design a relational database schema
capable of supporting the given business scenario and storing the data provided in
the sample data file.
Task Two: Write SQL code to implement your database design. You should save your code and
use constraints, default values, ON DELETE clauses, etc as appropriate for the
business scenario.
Task Three: Implement your database using either SQL Server OR MySQL OR Azure Data Studio
and populate it with the data provided in the sample data file. 
Task Four: Create a Jupyter Notebook and connect it to your database. Develop SQL code to test
that your database supports each of the Business Processes given in the previous
section. Use the templates provided in labs to write Python code and combine it with
the SQL code in the connected Jupyter Notebook.

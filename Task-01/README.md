# 📘 Task-01 – BestVoyageTravel Database Implementation

## Overview

This project delivers the **design and implementation** of a relational database for **BestVoyageTravel**, a company specializing in managing voyages, boats, and crew assignments.

The work covers the complete development lifecycle:

- **Conceptual Design** → Entity Relationship Diagram (ERD)  
- **Logical Design** → Relational Schema & Normalization  
- **Physical Implementation** → SQL DDL & DML Scripts  
- **Data Manipulation** → Queries, Procedures, and Views  

The objective is to demonstrate:  
- Sound database design principles  
- Implement keys, constraints, and normalization rules 
- Develop optimized SQL scripts for data retrieval and reporting
- Full compliance with the given requirements  

---

## 1.1 Entity Relationship Diagram (ERD)
The Entity Relationship Diagram (ERD) provides a **conceptual model** of the Best Voyage Travel database, identifying entities, attributes, and relationships that define how data is interconnected.

**Key Entities & Relationships:**

* **Voyage**: Represents the travel packages offered by the company. Each voyage is uniquely identified by `voyage_number` and includes attributes such as `name`, `description`, `cost`, and `duration`.
* **Boat**: Represents vessels assigned to voyages. Identified by `registration_number` and includes capacity details. A single voyage may use multiple boats → *One-to-Many (1:M)*.
* **Sailor**: Employees serving as sailors, with attributes for identification, employment, and personal details.
* **Boat_Sailor (Shift)**: Linking entity resolving the *Many-to-Many (M:N)* relationship between Boat and Sailor. Tracks which sailors work on which boats and the number of `working_hours`.
* **Captain**: Specialized role, one sailor per voyage at any given time → *One-to-One (1:1)* relationship with Voyage.

✅ This ERD reflects operational requirements such as voyage scheduling, boat allocation, crew assignment, and captain appointments. 

---

## 1.2 Relational Schema
The ERD was translated into an **initial schema**, defining entities, attributes, and relationships with primary and foreign keys.

⚠️ The schema effectively captured requirements but included **partial dependencies** (e.g., Boat) and **transitive dependencies** (e.g., Sailor), which necessitated normalization.

---

## 1.3 Normalization
Normalization was applied to improve **data integrity**, reduce redundancy, and enforce dependency rules.

### First Normal Form (1NF)

* Achieved by ensuring **atomic attributes** and no repeating groups.

### Second Normal Form (2NF)

* Removed **partial dependencies**.
* Example: `Boat` table was decomposed into:

  * **Boat** (`registration_number`, `voyage_number`)
  * **Boat_Details** (`registration_number`, `num_of_passengers`)

### Third Normal Form (3NF)

* Removed **transitive dependencies**.
* `Sailor` table was decomposed into:

  * **Sailor** (personal/employment details)
  * **Sailor_Address** (address details, linked by `employee_number`).
* A dedicated **Captain** table was created to manage appointments, preventing redundancy in `Voyage`.

✅ Final schema is fully in **3NF**, ensuring that all non-key attributes depend only on their respective primary keys.
 
---

## 1.4 Data Dictionary
A **data dictionary** was developed to document for each table in the final schema, including:  
  - Field names  
  - Descriptions  
  - Key attributes (Primary / Foreign)  
  - Data types and precision  

✅ Serves as a **reference guide** for developers and ensures uniform understanding of the database structure.  

---

## 1.5 Database Creation & Data Insertion
- Built the **BestVoyageTravel database** with 7 normalized tables in **SQL Server Management Studio (SSMS)**.  
- Enforced **PK–FK constraints and business rules**.  
- Populated each table with **20 realistic sample records** for testing.  
- Verified functionality using validation queries.  

📂 **Script:** `1.5_Create_and_Insert.sql`  

---

## 1.6 Queries, Procedures, and Views
Developed SQL operations to extract insights and support business processes:

- **Queries:** Aggregations, wildcard searches, conditional selections, and joins.  
- **Stored Procedures:** Encapsulated reusable operations such as retrieving sailor details, fetching voyage information, listing boats per voyage, and updating salaries.  
- **Views:** Created virtual tables for simplified reporting, including voyage summaries, sailor details, captain assignments, and high-earning sailors.  

📂 **Script:** `1.6_Queries_Procedures_Views.sql`  

---

## How to Run
1. Open **SQL Server Management Studio (SSMS)** (or preferred SQL client).  
2. Run `1.5_Create_and_Insert.sql` to create the database and load sample data.  
3. Run `1.6_Queries_Procedures_Views.sql` to execute queries, procedures, and views.
4. Verify results using `SELECT`, `EXEC` and `CALL` commands.
---

## Deliverables
- ERD Diagram  
- Relational Schema Documentation  
- Normalization Notes  
- Data Dictionary (Tabular Format)  
- SQL Script – Database & Inserts → `1.5_Create_and_Insert.sql`  
- SQL Script – Queries, Procedures, Views → `1.6_Queries_Procedures_Views.sql`  
- README File 

---

## Conclusion
With this implementation, the **BestVoyageTravel system** achieves a well-structured, normalized, and query-ready database that supports:  

- **Reliable daily operations**  
- **Data integrity and consistency**  
- **Efficient reporting and analytics**  
- **Scalability for future requirements**  

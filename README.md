# ShopZada
Course Project: ShopZada 2.0 – Enterprise Data Warehouse Build #
(under progress)

## Getting Started
Prerequisites(under progress)

**Docker**

[Windows](https://docs.docker.com/desktop/setup/install/windows-install/)

[Mac](https://docs.docker.com/desktop/setup/install/mac-install/)

[Linux](https://docs.docker.com/desktop/setup/install/linux/)

**Tableau**

[Tableau Desktop](https://www.tableau.com/products/desktop/download)

## Installation
1. Git clone the repo and navigate to the folder
```
$ git clone https://github.com/FRADMGit/ShopZada

$ cd ShopZada
```
2. Docker compose
```
$ docker compose up -d
```
3.Log in with Kestra
```
# Enter the address in your browser: localhost:8080
# Create new account or log in with:
Email: admin@kestra.io  
First Name: kestra
Last Name: kestra
Password: Kestra123
``` 
4. Go to Flows and Import shopzada.elt.yaml
5. Open the flow, go to Edit → Files, and upload these files:   
Datasets/  
├── your_data.csv  
├── your_data.html  
├── your_data.json  
├── your_data.pickle  
├── your_data.parquet  

# Connect To TABLEAU 

1. Download [Tableau Driver](https://www.tableau.com/support/drivers)
1. 0pen Tableau Desktop
3. Connect to a server → More → PostgreSQL  
   - Server: `localhost`  
   - Port: `5432`  
   - Database: `kestra`  
   - Username: `kestra`  
   - Password: `k3str4`

> [!TIP]
> Clear the port in order to avoid conflict when connecting to the postgres server
  
---

# HOW TO OPEN DATABASE IN PGADMIN4 [OPTIONAL]
1. Make sure you have run `docker compose up -d`  
2. In your browser, open `localhost:5050`  
      Username: `admin@shopzada.com `  
      Password: `PgAdminPassword123`  
4. Right-click on Servers → Register → Server…  
   - **General:** choose any name  
   - **Connection:**  
      Host name/address: `postgres`  
      Port: `5432`
      Maintenance Database: `kestra`  
      Username: `kestra`  
      Password: `k3str4`  
5. Save

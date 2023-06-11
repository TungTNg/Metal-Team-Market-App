import mysql.connector
from mysql.connector import Error
from datetime import datetime, timedelta

class MarketplaceDB:
    def __init__(self):
        try:
            self.connection = mysql.connector.connect(
                host='localhost',
                database='metal_team_marketplace',
                user='your_mysql_username',
                password='your_mysql_password'
            )

            if self.connection.is_connected():
                print("Successfully connected to database")

        except Error as e:
            print("Error while connecting to MySQL", e)

    def close_connection(self):
        if self.connection.is_connected():
            self.connection.close()
            print("MySQL connection is closed")

    def list_products(self):
        try:
            cursor = self.connection.cursor()
            cursor.execute("""
                SELECT p.product_id, p.product_name, p.price, i.quantity 
                FROM Product p 
                JOIN Inventory i ON p.product_id = i.product_id;
            """)
            rows = cursor.fetchall()

            if rows:
                print("{:<10} {:<50} {:<10} {:<10}".format('Product ID', 'Product', 'Price', 'Quantity'))
                print("-"*81)

                for row in rows:
                    price = "${:.2f}".format(row[2])
                    print("{:<10} {:<50} {:<10} {:<10}".format(row[0], row[1], price, row[3]))
            else:
                print("No products found in inventory")

        except Error as e:
            print("Error", e)

    def create_product(self, product_name, description, price):
        try:
            cursor = self.connection.cursor()
            cursor.execute(f"INSERT INTO Product (product_name, description, price) VALUES ('{product_name}', '{description}', {price});")
            self.connection.commit()
            if cursor.rowcount > 0:
                print(f"Product '{product_name}' successfully created")
            else:
                print("Failed to create product")

        except Error as e:
            print("Error", e)

    def modify_inventory(self, product_id, new_quantity):
        try:
            cursor = self.connection.cursor()
            cursor.execute(f"UPDATE Inventory SET quantity = {new_quantity} WHERE product_id = {product_id};")
            self.connection.commit()
            if cursor.rowcount > 0:
                print(f"Inventory for product_id {product_id} updated")
            else:
                print(f"No product with id {product_id} found in inventory.")

        except Error as e:
            print("Error", e)

    def delete_product(self, product_id):
        try:
            cursor = self.connection.cursor()
            cursor.execute(f"DELETE FROM Product WHERE product_id = {product_id};")
            self.connection.commit()
            if cursor.rowcount > 0:
                print(f"Product with id {product_id} deleted")
            else:
                print(f"No product with id {product_id} found in inventory.")

        except Error as e:
            print("Error", e)

    def most_popular_products(self, start_date, end_date):
        try:
            cursor = self.connection.cursor()
            cursor.execute(f"""
                SELECT p.product_name, SUM(o.purchase_quantity) AS total_sold, AVG(r.rating) AS avg_rating 
                FROM Product p 
                JOIN `Order` o ON p.product_id = o.product_id
                JOIN Review r ON p.product_id = r.product_id
                WHERE o.transaction_date BETWEEN '{start_date}' AND '{end_date}'
                GROUP BY p.product_id 
                ORDER BY total_sold DESC, avg_rating DESC;
            """)
            rows = cursor.fetchall()

            if rows:
                for row in rows:
                    print(f"Product: {row[0]}, Total Sold: {row[1]}, Average Rating: {row[2]}")
            else:
                print("No products found in the given time range")

        except Error as e:
            print("Error", e)

    def least_popular_products(self, start_date, end_date):
        try:
            cursor = self.connection.cursor()
            cursor.execute(f"""
                SELECT p.product_name, SUM(o.purchase_quantity) AS total_sold, AVG(r.rating) AS avg_rating 
                FROM Product p 
                JOIN `Order` o ON p.product_id = o.product_id
                JOIN Review r ON p.product_id = r.product_id
                WHERE o.transaction_date BETWEEN '{start_date}' AND '{end_date}'
                GROUP BY p.product_id 
                ORDER BY total_sold ASC, avg_rating ASC;
            """)
            rows = cursor.fetchall()

            if rows:
                for row in rows:
                    print(f"Product: {row[0]}, Total Sold: {row[1]}, Average Rating: {row[2]}")
            else:
                print("No products found in the given time range")

        except Error as e:
            print("Error", e)

    def get_inactive_users(self, months):
        try:
            cursor = self.connection.cursor()
            days = months * 30
            last_date = (datetime.now() - timedelta(days=days)).strftime('%Y-%m-%d')
            cursor.execute(f"""
                SELECT u.full_name, u.email, mp.most_purchased_product
                FROM User u 
                LEFT JOIN (
                    SELECT o.user_id, p.product_name as most_purchased_product
                    FROM `Order` o
                    JOIN Product p ON o.product_id = p.product_id
                    GROUP BY o.user_id, p.product_name
                    HAVING COUNT(*) = (
                        SELECT COUNT(*)
                        FROM `Order` o2
                        WHERE o2.user_id = o.user_id
                        GROUP BY o2.product_id
                        ORDER BY COUNT(*) DESC
                        LIMIT 1
                    )
                ) mp ON u.user_id = mp.user_id
                WHERE u.user_id NOT IN (
                    SELECT o.user_id
                    FROM `Order` o
                    WHERE o.transaction_date >= '{last_date}'
                )
                GROUP BY u.user_id;
            """)
            rows = cursor.fetchall()

            if rows:
                for row in rows:
                    name = row[0]
                    email = row[1]
                    most_purchased_product = row[2] if row[2] is not None else "No purchases"
                    print(f"User: {name}, Email: {email}, Most Frequently Purchased Product: {most_purchased_product}")
            else:
                print("No inactive users found")

        except Error as e:
            print("Error", e)

# Initialize the application
app = MarketplaceDB()

while True:
    # Print menu
    print("\n1. List products in inventory")
    print("2. Create new product")
    print("3. Modify product quantity in inventory")
    print("4. Delete product from inventory")
    print("5. Show most popular products for a given time range")
    print("6. Show least popular products for a given time range")
    print("7. Get list of inactive users")
    print("8. Exit\n")

    try:
        selection = int(input("Please select an option: "))

        if selection == 1:
            print()
            app.list_products()
        elif selection == 2:
            product_name = input("Enter product name: ")
            description = input("Enter product description: ")
            price = float(input("Enter product price: "))
            print()
            app.create_product(product_name, description, price)
        elif selection == 3:
            product_id = int(input("Enter product ID to modify: "))
            new_quantity = int(input("Enter new quantity: "))
            print()
            app.modify_inventory(product_id, new_quantity)
        elif selection == 4:
            product_id = int(input("Enter product ID to delete: "))
            print()
            app.delete_product(product_id)
        elif selection == 5:
            start_date = input("Enter start date (YYYY-MM-DD): ")
            end_date = input("Enter end date (YYYY-MM-DD): ")
            print()
            app.most_popular_products(start_date, end_date)
        elif selection == 6:
            start_date = input("Enter start date (YYYY-MM-DD): ")
            end_date = input("Enter end date (YYYY-MM-DD): ")
            print()
            app.least_popular_products(start_date, end_date)
        elif selection == 7:
            months = int(input("Enter number of months for inactivity check: "))
            print()
            app.get_inactive_users(months)
        elif selection == 8:
            print("Exiting application...")
            break
        else:
            print("Invalid selection, please choose a valid option.")
            
    except Exception as e:
        print("An error occurred: ", e)

# Close connection
app.close_connection()

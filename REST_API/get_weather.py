import requests

def get_temperature(data, target_date):
    for item in data['list']:
        if item['dt_txt'] == target_date:
            return item['main']['temp']

def get_wind_speed(data, target_date):
    for item in data['list']:
        if item['dt_txt'] == target_date:
            return item['wind']['speed']

def get_pressure(data, target_date):
    for item in data['list']:
        if item['dt_txt'] == target_date:
            return item['main']['pressure']

def main():
    url = "https://samples.openweathermap.org/data/2.5/forecast/hourly?q=London,us&appid=b6907d289e10d714a6e88b30761fae22"
    response = requests.get(url)
    data = response.json()

    while True:
        print("1. Get Temperature")
        print("2. Get Wind Speed")
        print("3. Get Pressure")
        print("0. Exit")

        choice = input("Enter your choice: ")

        if choice == '0':
            break
        elif choice in ['1', '2', '3']:
            target_date = input("Enter date with time (YYYY-MM-DD HH:MM:SS): ")
            if choice == '1':
                result = get_temperature(data, target_date)
                print(f"Temperature at {target_date}: {result} K")
            elif choice == '2':
                result = get_wind_speed(data, target_date)
                print(f"Wind Speed at {target_date}: {result} m/s")
            elif choice == '3':
                result = get_pressure(data, target_date)
                print(f"Pressure at {target_date}: {result} hPa")
        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main()

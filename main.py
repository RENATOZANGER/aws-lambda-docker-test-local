from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager

def lambda_handler(event, context):
    service = Service(ChromeDriverManager().install())
    options = webdriver.ChromeOptions()
    options.add_argument("--headless")
    options.add_argument("--disable-application-cache")
    options.add_argument("--disable-infobars")
    options.add_argument("--no-sandbox")
    options.add_argument("--hide-scrollbars")
    options.add_argument("--single-process")
    options.add_argument("--ignore-certificate-errors")

    driver = webdriver.Chrome(service=service, options=options)
    driver.get("https://www.example.com")

    title = driver.title
    print("Title of the page:", title)
    driver.quit()
    return {
        'statusCode': 200,
        'body': f'Title of the page: {title}'
    }

#from flask import Flask


#app = Flask(__name__)

#@app.route('/')
#def hello():
  #  return 'Hello world!'

#if __name__ == '__main__':
  #  app.run()
   


#@app.route('/about')
#def about():
  #  return 'This app is powered by Docker!'
    
#@app.route('/info')
#def info():
   # return 'Some important information!'

from fastapi import FastAPI

# Only define the app ONCE as a FastAPI instance
app = FastAPI()



@app.get("/")
async def root():
    return {"message": "Hello world!"}
    
@app.get("/info")
async def read_info():
    return {"message": "Hello from FastAPI"}

@app.get("/about")
async def about():
    return {"message": "This app is powered by Docker!"}


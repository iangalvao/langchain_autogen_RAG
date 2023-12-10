build:
	docker build -t autogen_notebook .

run:
	docker run -it -p 8888:8888 --net text-generation-webui-docker_default -v $$(pwd)/notebooks/:/my_app/notebooks/ autogen_notebook jupyter notebook --ip 0.0.0.0 --no-browser
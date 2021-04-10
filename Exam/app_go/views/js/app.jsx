class HelloWorld extends React.Component {
  render() {
    return (
      <div className="container">
        <div className="row">
          <div className="col-xs-8 col-xs-offset-2 jumbotron text-center">
            <h2>Andersen DevOps course</h2>
            <h1>Hello World 1!</h1>
            <h3>Hello World web app created with Golang + Gin + React</h3>
            <h4><a href="https://github.com/cskonopka/go-gin-react">Github</a></h4>
          </div>
        </div>
      </div>
    );
  }
}

ReactDOM.render(<HelloWorld />, document.getElementById("app"));

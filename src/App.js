import React, { useEffect, useState} from 'react';
import axios from 'axios';
import './project.css'
import MoviePage from './moviepage';
import CustomerPage from './customerpage'
import {BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import { useNavigate } from 'react-router-dom';
import pdfMake from "pdfmake/build/pdfmake";
import pdfFonts from "pdfmake/build/vfs_fonts";


pdfMake.vfs = pdfFonts.pdfMake.vfs;

const ToolTip = ({ hoveredMovie, hoveredActor, actorTopMovies }) => {

  const style = {
    fontFamily: 'stencil, fantasy',
    position: 'fixed',
    top: '50%',
    left: '90%',
    transform: 'translate(-50%, -50%)',
    color: 'lightgreen',
    backgroundColor: 'crimson',
    border: '1px solid #ccc',
    padding: '10px',
    zIndex: 1
  };

  if(hoveredMovie) {
      
    return (
    
      <div style = {style}>
        <h4>{hoveredMovie.title}</h4>
        <p>{`Rented: ${hoveredMovie.rental_count} times`}</p>
        <p>{`Genre: ${hoveredMovie.genre}`}</p>
      </div>
      );
  };
  if(hoveredActor) {

    return (

      <div style = {style}>
        <h4>{hoveredActor.first_name} {hoveredActor.last_name}</h4>
        <ul>
          {actorTopMovies.map((movie, index) => (
            <li key={index}>{movie.title} (Rented {movie.rental_count} times)</li>
          ))}
        </ul>
        <p></p>
      </div>
    );
  }
  return null;
};

function Project() {

  const [hCheckState, updatehCheck] = useState('');
  
  const [top5Movies, setTop5Movies] = useState([]);
  const [showTop5Movies, setShowTop5Movies] = useState(false);
  const [hoveredMovie, setHoveredMovie] = useState(null);

  const [top5Actors, setTop5Actors] = useState([]);
  const [showTop5Actors, setShowTop5Actors] = useState(false);
  const [hoveredActor, setHoveredActor] = useState(null);
  const [actorTopMovies, setActorTopMovies] = useState([]);

  useEffect(() => {
    axios.get('http://localhost:3001/health-check')
      .then(response => {
        updatehCheck(response.data);
      })
      .catch(error => {
        console.error("Data error...", error);
        updatehCheck("Data error...");
      });
  }, []);

  useEffect(() => {
    axios.get('http://localhost:3001/top-5-rented-movies')
    .then(response => {
      console.log(response.data);
      setTop5Movies(response.data);
    })
    .catch(error => {
      console.error("Data Error...");
    });
  }, []);

  useEffect(() => {
    axios.get('http://localhost:3001/top-5-rented-actors')
    .then(response => {
      console.log(response.data);
      setTop5Actors(response.data);
    })
    .catch(error => {
      console.error("Data Error...");
    });
  }, []);

  useEffect(() => {
    if(hoveredActor) {

      axios.get(`http://localhost:3001/actors-top-5/${hoveredActor.actor_id}`)
        .then(response => {
          setActorTopMovies(response.data);
        })
        .catch(error => {
          console.error("Data Error...");
        });
    }
  }, [hoveredActor]);

  const handleShowTop5Movies = () => {

    setShowTop5Movies(!showTop5Movies);
  };

  const handleShowTop5Actors = () => {

    setShowTop5Actors(!showTop5Actors);
  };


  const style = {
    fontFamily: 'stencil, fantasy',
    backgroundColor: 'lightgreen',
    color: 'crimson',
    padding: '15px',
    textAlign: 'center',
    fontSize: '25px',
  };

  const bStyle = {
    fontFamily: 'stencil, fantasy',
    backgroundColor: 'crimson',
    color: 'white',
    fontSize: '12px',
    padding: '5px 10px',
    margin: '10px',
    cursor: 'pointer',
    border: 'none',
    borderRadius: '5px'
  };

  const overlineText = {
    textDecoration: 'overline'
  };
  
  return (
    <div className="Project">
      <ToolTip hoveredMovie = {hoveredMovie} hoveredActor = {hoveredActor} actorTopMovies = {actorTopMovies}/>
      <header className="Project-Header" style = {style}>
        <h1 style = {overlineText}>Home</h1>
          <button style = {bStyle} onClick={handleShowTop5Movies}>Show Top 5 Rented Movies</button>
          <button style = {bStyle} onClick={handleShowTop5Actors}>Show Top 5 Rented Actors</button>
            {showTop5Movies && (
              <>
                <h2> Top 5 Rented Movies</h2>
                  <table 
                    border="1"
                    style = {{
                      margin: "auto",
                      width: "50%",
                    }}
                  >
                  <thead>
                    <tr>
                      <th>Title</th>
                      <th>Rental Count</th>
                    </tr>
                  </thead>
                  <tbody>
                    {top5Movies.map((movie, index) => (
                      <tr 
                        key={index}
                        onMouseEnter={() => setHoveredMovie(movie)}
                        onMouseLeave={() => setHoveredMovie(null)}
                      >
                        <td>{movie.title}</td>
                        <td>{movie.rental_count} times</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </>
            )}
            {showTop5Actors && (
              <>
                <h2> Top 5 Rented Actors </h2>
                  <table
                    border="1"
                    style = {{
                      margin: "auto",
                      width: "50%",
                    }}
                  >
                  <thead>
                    <tr>
                      <th>Actor ID</th>
                      <th>Name</th>
                      <th>Movie Count</th>
                    </tr>
                  </thead>
                  <tbody>
                    {top5Actors.map((actor, index) => (
                      <tr 
                        key={index}
                        onMouseEnter={() => setHoveredActor(actor)}
                        onMouseLeave={() => setHoveredActor(null)}
                      >
                        <td>{actor.actor_id}</td>
                        <td>{actor.first_name} {actor.last_name}</td>
                        <td>{actor.movie_count}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </>
            )}
      </header>
    </div>
  );
}

const Navigation = () => {

  const navigate = useNavigate();

  const generatePDF = () => {

    axios({
      method: 'get',
      url: 'http://localhost:3001/generate-customer-report',
      responseType: 'blob'
    })
    .then(response => {
      const url = window.URL.createObjectURL(new Blob([response.data]));
      const link = document.createElement('a');
      link.href = url;
      link.setAttribute('download', 'customer_rental_report.pdf');
      document.body.appendChild(link);
      link.click();
    })
    .catch(error => {
      console.error("Data Error...", error);
    })
  };

  const style = {
    fontFamily: 'stencil, fantasy',
    backgroundColor: 'lightgreen',
    color: 'white',
    padding: '15px',
    textAlign: 'center'
  };

  const bStyle = {
    fontFamily: 'stencil, fantasy',
    backgroundColor: 'crimson',
    color: 'white',
    fontSize: '20px',
    padding: '8px 15px',
    margin: '5px',
    cursor: 'pointer',
    border: 'none',
    borderRadius: '5px',
    textDecoration: 'underline'
  };

  return (
    <nav style = {style}>
          <button style = {bStyle} onClick={() => navigate("/")}>Home</button>
          <button style = {bStyle} onClick={() => navigate("/moviepage")}>Movies</button>
          <button style = {bStyle} onClick={() => navigate("/customerpage")}>Customer Info</button>
          <button style = {bStyle} onClick={generatePDF}>Generate Customer Rental Report</button>
    </nav>
  );
};

const App = () => {

  return (
    <Router>
      <div>
        <Navigation />
        <Routes>
          <Route path="/" element={<Project />} />
          <Route path="/moviepage" element={<MoviePage />} />
          <Route path="/customerpage" element={<CustomerPage />} />
        </Routes>
      </div>
    </Router>
  );
};

export default App;

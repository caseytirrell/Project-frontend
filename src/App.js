import React, { useEffect, useState} from 'react';
import axios from 'axios';

let hCheck = 'http://localhost:3001/health-check';

function Project() {

  const [state, update] = useState('');

  useEffect(() => {
    axios.get(hCheck)
      .then(response => {
        update(response.data);
      })
      .catch(error => {
        console.error("Data error...", error);
        update("Data error...");
      });
  }, []);

  return (

    <div className = "Project">
      <header className = "Project-Header">
        <p>{state}</p>
      </header>
    </div>
  );
}

export default Project;
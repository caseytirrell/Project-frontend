import React, {useEffect, useState} from 'react';
import axios from 'axios';

const MoviePage = () => {

	const [movies, setMovies] = useState([]);
	const [search, setSearch] = useState({
		filmName: '',
		actorName: '',
		genre: ''
	});

	const handleSearch = () => {

		axios.get('http://localhost:3001/search-movies', {
		params: search
		})
		.then(response => {
			console.log(response.data);
			setMovies(response.data);
		})
		.catch(error => {
			console.error("Data Error...", error);
		});
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
    	fontSize: '15px',
    	padding: '5px 10px',
    	margin: '10px',
    	cursor: 'pointer',
    	border: 'none',
    	borderRadius: '5px'
  	};

	const sStyle = {

   		fontFamily: 'stencil, fantasy',
   		backgroundColor: 'white',
   		color: 'crimson',
   		fontSize: '18px',
   		padding: '5px 10px',
   		margin: '8px',
   		cursor: 'pointer',
   		border: 'none',
   		borderRadius: '5px'
	};

	const lStyle = {

    		fontFamily: 'stencil, fantasy',
    		backgroundColor: 'white',
   			color: 'crimson',
   			padding: '15px',
   			textAlign: 'center'	
	};

	const overlineText = {
		textDecoration: 'overline'
	}

	return (

		<div style = {style}>
			<h1 style = {overlineText}>Movies Page</h1>
			<h2>Search Movies</h2>
			<input style = {sStyle}
				type="text"
				placeholder="Movie Name"
				value={search.filmName}
				onChange={(e) => setSearch({ ...search, filmName: e.target.value })}
			/>
			<input style = {sStyle}
				type="text"
				placeholder="Actor Name"
				value={search.actorName}
				onChange={(e) => setSearch({ ...search, actorName: e.target.value })}
			/>
			<input style = {sStyle}
				type="text"
				placeholder="Genre"
				value={search.genre}
				onChange={(e) => setSearch({ ...search, genre: e.target.value })}
			/>
			<p></p>
			<button style = {bStyle} onClick={handleSearch}>Search</button>
			
			<h2 style = {lStyle}>All Movies</h2>
			{movies.map((movie, index) => (
				<div style = {lStyle} key={index}>
					<h3 style = {overlineText}>{movie.title}</h3>
					<h4>{movie.description}</h4>
					<p>Special Features: {movie.special_features}</p>
					<p>Released: {movie.release_year}</p>
					<p>Rating: {movie.rating}</p>
					<p>Length: {movie.length} Minutes</p>
				</div>
			))}
		</div>
	);
};

export default MoviePage;

import React, {useEffect, useState} from 'react';
import axios from 'axios';
import Modal from 'react-modal';

const CustomerModal = ({ isOpen, onRequestClose, customers, currentFilmId}) => {

	const handleReturn = (customerId, filmId) => {

		axios.post('http://localhost:3001/return-movie', { 
			customerId, 
			filmId
		})
		.then(response => {
			console.log('Server response:', response.data);
			window.alert('Movie returned successfully...');
		})
		.catch(error => {
			console.error("Data Error...", error);
			window.alert('Error in returning movie...');
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
		<Modal isOpen={isOpen} onRequestClose={onRequestClose}>
			<h2 style = {style}>Customers Renting This Movie</h2>
			<ul style = {sStyle}>
				{customers.map((customer, index) => (
					<li key={index}>
						{customer.first_name} {customer.last_name}
						<button style = {bStyle} onClick={() => handleReturn(customer.customer_id, currentFilmId)}>
							Return Movie
						</button>
					</li>
				))}
			</ul>
			<button style = {bStyle} onClick={onRequestClose}>Close</button>
		</Modal>
	);
};

const RentalModal = ({ isOpen, onRequestClose, onRent, filmId }) => {

	const [customerId, setCustomerId] = useState('');
	const [staffId, setStaffId] = useState('');

	const handle = () => {

		if(!isNaN(customerId) && !isNaN(staffId)) {
			onRent(filmId, Number(customerId), Number(staffId));
			onRequestClose();
		}
		else {
			console.error("Both Customer ID and Staff ID must be valid");
		}
		
	};

	return (
		<Modal isOpen={isOpen} onRequestClose={onRequestClose}>
			<h2>Rent Movie</h2>
			<label>
				Customer ID:
				<input
					type="text" 
					value={customerId || ''} 
					onChange={(e) => setCustomerId(Number(e.target.value))} 
				/>
			</label>
			<label>
				Staff ID:
				<input
					type="text"
					value={staffId || ''}
					onChange={(e) => setStaffId(Number(e.target.value))}
				/>
			</label>
			<button onClick={handle}>Rent</button>
			<button onClick={onRequestClose}>Cancel</button>
		</Modal>
	);
};

const MoviePage = () => {

	const [movies, setMovies] = useState([]);
	const [search, setSearch] = useState({
		filmName: '',
		actorName: '',
		genre: ''
	});

	const [modal, setModal] = useState(false);
	const [film, setFilm] = useState(null);

	const [customerModal, setCustomerModal] = useState(false);
	const [currentCustomers, setCurrentCustomers] = useState([]);

	const [currentFilmId, setCurrentFilmId] = useState(null);

	const handleSearch = () => {

		axios.get('http://localhost:3001/search-movies', {
		params: search
		})
		.then(response => {
			console.log('Server response:', response.data);
			setMovies(response.data);
		})
		.catch(error => {
			console.error("Data Error...", error);
		});
	};

	const handleRent = (filmId, customerId, staffId) => {

		console.log(filmId);
		axios.post('http://localhost:3001/movie-rentals', {

			customerId: customerId,
			filmId: filmId,
			staffId: staffId
		}, {
			headers: {
				'Content-Type': 'application/json'
			}
		})
		.then(response => {
			console.log(response.data);
			setModal(false);
		})
		.catch(error => {
			console.error("Data Error...", error);
		});
	
	};

	const handleShowCustomers = (filmId) => {
		axios.get(`http://localhost:3001/current-rentals/${filmId}`)
		.then(response => {
			console.log('Attempting to open CustomerModal')
			setCurrentCustomers(response.data);
			setCurrentFilmId(filmId);
			setCustomerModal(true);
		})
		.catch(error => {
			console.error("Data Error...", error);
		});
	};

	const openModal = (filmId) => {
		setFilm(filmId);
		setModal(true);
	};

	const closeModal = () => {
		setModal(false);
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
					<button style = {bStyle} onClick={() => openModal(movie.film_id)}>Rent Movie</button>
					<button style = {bStyle} onClick={() => handleShowCustomers(movie.film_id)}>Show Customers</button>
				</div>
			))}
			{modal && <RentalModal
				isOpen={modal}
				onRequestClose={closeModal}
				onRent={handleRent}
				filmId={film}
			/>}
			{console.log('customerModal state:', customerModal)}
			{console.log('currentCustomers state:', currentCustomers)}
			{customerModal && <CustomerModal
				isOpen={customerModal}
				onRequestClose={() => setCustomerModal(false)}
				customers={currentCustomers}
				currentFilmId={currentFilmId}
			/>}
		</div>
	);
};

export default MoviePage;

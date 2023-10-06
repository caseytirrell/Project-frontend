import React, {useEffect, useState} from 'react';
import axios from 'axios';
import Modal from 'react-modal';

const CustomerModal = ({ isOpen, onRequestClose, onSubmit }) => {

	const [data, setData] = useState({
		storeId: '',
		firstName: '',
		lastName: '',
		email: '',
		phone: '',
		address: '',
		city: '',
		district: '',
		country: ''
	});

	const handle = (e) => {

		const { name, value } = e.target;
		setData({
			...data,
			[name]: value
		});
	};

	const submit = (e) => {

		e.preventDefault();
		onSubmit(data);
	};

	return (

		<Modal isOpen={isOpen} onRequestClose={onRequestClose}>
			<h2>Add New Customer</h2>
			<form onSubmit={submit}>
				<label>
					Store ID:
					<input
						type="text" 
						name="storeId"
						value={data.storeId} 
						onChange={handle} 
					/>
				</label>
				<p></p>
				<label>
					First Name:
					<input
						type="text"
						name="firstName"
						value={data.firstName}
						onChange={handle}
					/>
				</label>
				<p></p>
				<label>
					Last Name:
					<input
						type="text"
						name="lastName"
						value={data.lastName}
						onChange={handle}
					/>
				</label>
				<p></p>
				<label>
					Email Address:
					<input
						type="text"
						name="email"
						value={data.email}
						onChange={handle}
					/>
				</label>
				<p></p>
				<label>
					Phone:
					<input
						type="text"
						name="phone"
						value={data.phone}
						onChange={handle}
					/>
				</label>
				<p></p>
				<label>
					Home Address:
					<input
						type="text"
						name="address"
						value={data.address}
						onChange={handle}
					/>
				</label>
				<p></p>
				<label>
					City:
					<input
						type="text"
						name="city"
						value={data.city}
						onChange={handle}
					/>
				</label>
				<p></p>
				<label>
					District:
					<input
						type="text"
						name="district"
						value={data.district}
						onChange={handle}
					/>
				</label>
				<p></p>
				<label>
					Country:
					<input
						type="text"
						name="country"
						value={data.country}
						onChange={handle}
					/>
				</label>
				<p></p>
				<button type="submit">Submit</button>
			</form>
			<button onClick={onRequestClose}>Cancel</button>
		</Modal>
	);
};

const ToolTip = ({ hoveredCustomer, customerRentals, isToolTipOut }) => {

	const style = {
    fontFamily: 'stencil, fantasy',
    position: 'fixed',
    top: '50%',
    left: '80%',
    transform: 'translate(-50%, -50%)',
    color: 'lightgreen',
    backgroundColor: 'crimson',
    border: '1px solid #ccc',
    padding: '10px',
    zIndex: 1
  }

  const scrollStyle = {

  	height: '100px',
  	overflowY: 'scroll',
  	fontSize: 'small'
  }

  const overlineText = {
		textDecoration: 'overline'
	}

  if(isToolTipOut && hoveredCustomer && customerRentals) {

  	return (

  		<div style = {style}>
  			<h4 style = {overlineText}>{hoveredCustomer.first_name} {hoveredCustomer.last_name}</h4>
  			<p>Total Movies Rented: {customerRentals.totalCount}</p>
  			<div style = {scrollStyle}>
  				{customerRentals.movies && customerRentals.movies.map((movie, index) => (
  					<p key = {index}>{movie.title}</p>
  				))}
  			</div>
  		</div>
  	);
  }
}


const CustomerPage = () => {

	const[showCustomers, setShowCustomers] = useState(false);
	const[customers, setCustomers] = useState([]);
	const[search, setSearch] = useState({

		customerID: '',
		customerName: ''
	});

	const [isToolTipOut, showToolTip] = useState(false);
	const [hoveredCustomer, setHoveredCustomer] = useState(null);
	const [customerRentals, setCustomerRentals] = useState([]);

	const [modal, setModal] = useState(false);
	const [newCustomers, setNewCustomers] = useState([]);

	const toggleToolTip = (customer) => {

		if(isToolTipOut && hoveredCustomer && hoveredCustomer.customer_id === customer.customer_id) {

			showToolTip(false);
			setHoveredCustomer(null);
		}
		else {

			setHoveredCustomer(customer);
			showToolTip(true);
		}
	};

	useEffect(() => {

		if(hoveredCustomer) {

			axios.get(`http://localhost:3001/customer-rentals/${hoveredCustomer.customer_id}`)
			.then(response => {
				setCustomerRentals(response.data);
			})
			.catch(error => {
				console.error("Data Error...", error);
			});
		}
	}, [hoveredCustomer]);

	const handleSearch = () => {

		axios.get('http://localhost:3001/search-customers', {
		params: search
		})
		.then(response => {
			console.log(response.data);
			setCustomers(response.data);
			setShowCustomers(true);
		})
		.catch(error => {
			console.error("Data Error...", error);
		});
	};

	const allCustomers = () => {

		if(showCustomers) {

			setShowCustomers(false);
			setCustomers([]);
		}
		else {

			axios.get('http://localhost:3001/all-customers')
			.then(response => {
				console.log(response.data);
				setCustomers(response.data);
				setShowCustomers(true);
			})
			.catch(error => {
				console.error("Data Error...", error);
			});
		}
	};

	const openModal = () => setModal(true);
	const closeModal = () => setModal(false);

	const handleSubmit = (customerData) => {

		axios.post('http://localhost:3001/new-customer', customerData)
		.then(response => {

			console.log(response.data);
			setNewCustomers([...newCustomers, response.data]);
			closeModal();
		})
		.catch(error => {
			console.error("Data Error...", error);
		});
	}

	const handleDelete = (customerId) => {

		axios.delete(`http://localhost:3001/delete-customer/${customerId}`)
		.then(response => {
			console.log(response.data);
			const updateCustomers = customers.filter(c => c.customer_id !== customerId);
			setCustomers(updateCustomers);
		})
		.catch(error => {
			console.error("Deletion Error...", error);
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
   		fontSize: '18px',
   		padding: '10px 20px',
   		margin: '5px',
   		cursor: 'pointer',
   		border: 'none',
   		borderRadius: '5px'
	};

	const sStyle = {

   		fontFamily: 'stencil, fantasy',
   		backgroundColor: 'white',
   		color: 'crimson',
   		fontSize: '18px',
   		padding: '10px 20px',
   		margin: '5px',
   		cursor: 'pointer',
   		border: 'none',
   		borderRadius: '5px'
	};

	const lStyle = {

    		fontFamily: 'stencil, fantasy',
    		backgroundColor: 'white',
   			color: 'crimson',
   			padding: '15px',
   			textAlign: 'center',
   			textDecoration: 'none'	
	};

	const overlineText = {
		textDecoration: 'overline'
	}

	return (

		<div style = {style}>
			<ToolTip hoveredCustomer={hoveredCustomer} customerRentals={customerRentals} isToolTipOut={isToolTipOut} />
				<h1 style = {overlineText}>Customers Page</h1>
				<h2>Search Customers</h2>
				<input style = {sStyle}
					type="text"
					placeholder="Customer ID"
					value={search.customerID}
					onChange={(e) => setSearch({ ...search, customerID: e.target.value })}
				/>
				<input style = {sStyle}
					type="text"
					placeholder="Customer Name"
					value={search.customerName}
					onChange={(e) => setSearch({ ...search, customerName: e.target.value })}
				/>
				<button style = {bStyle} onClick={handleSearch}>Search</button>
				<p></p>
				<button style = {bStyle} onClick={openModal}>Add New Customer</button>
				<p></p>
				<button style = {bStyle} onClick={allCustomers}>Show All Customers</button>
				{modal && <CustomerModal isOpen={modal} onRequestClose={closeModal} onSubmit={handleSubmit} />}
				{showCustomers && (

					<h1 style = {lStyle}>Customers</h1>
				)}
				{showCustomers && (
				customers.map((customer, index) => (
					<div 
						style = {lStyle} 
						key={customer.customer_id}
					>
						<h3 style = {overlineText}>{customer.first_name} {customer.last_name}</h3>
						<p>Email: {customer.email}</p>
						<p>Customer ID: {customer.customer_id}</p>
						<p>Status: {customer.active ? 'Active' : 'Inactive'}</p>
						<button style = {bStyle} onClick={() => toggleToolTip(customer)}>Show Details</button>
						<button style = {bStyle} onClick={() => handleDelete(customer.customer_id)}>Delete Customer</button>
					</div>
				)))}
		</div>
	);
};

export default CustomerPage;

import React from 'react';
import './LandingPage.css';

const LandingPage = () => {
  return (
    <div className="landing-page">
      <h1>Cuttin' Up</h1>
      <div className="options">
        <button className="option-button" onClick={() => console.log('Start Game clicked')}>
          Start Game
        </button>
        <button className="option-button" onClick={() => console.log('Choose Vehicle clicked')}>
          Choose Vehicle
        </button>
        <button className="option-button" onClick={() => console.log('Shop clicked')}>
          Shop
        </button>
      </div>
    </div>
  );
};

export default LandingPage;
`
import React, { Component } from 'react'
`

class Header extends Component
  render: ->
    <div
      className='ui secondary menu'
      style={{backgroundColor: '#565bb0'}}>
      <div className='header item'>
        <img
          className='ui image'
          alt='imperative logo'
          src='https://uploads-ssl.webflow.com/5bae27a3939555a4ddb8d2ca/5cfec2f2d9a74915137139d3_Imperative%20Logo_White.svg'/>
      </div>
      <div className='header item' style={{color: 'white'}}>
        <h1>Schedule Manager tool</h1>
      </div>
    </div>



export default Header

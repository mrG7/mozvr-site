var camera, scene, renderer;
var vrEffect;
var vrControls;


function init() {

	stage = document.getElementById( 'stage' );
	camera = new THREE.PerspectiveCamera( 70, window.innerWidth / window.innerHeight, 0.1, 10000 );
	scene = new THREE.Scene();

	//sphere
	var geometry = new THREE.SphereGeometry( 8, 40, 40 );
	var material = new THREE.MeshBasicMaterial( { color: 0xffffff, wireframe:true, transparent: true, opacity: 0.2 } );
	var mesh = new THREE.Mesh( geometry, material );
	mesh.position.set( 0, 0, -6 );
	scene.add( mesh );

	//background sphere
	var geometry = new THREE.SphereGeometry( 500, 60, 40 );
	geometry.applyMatrix( new THREE.Matrix4().makeScale( -1, 1, 1 ) );
	var material = new THREE.MeshBasicMaterial( {
		map: THREE.ImageUtils.loadTexture( '/images/bg-sechelt.png' )
	} );
	var background = new THREE.Mesh( geometry, material );
	scene.add(background);

	//renderer
	renderer = new THREE.WebGLRenderer( { antialias: true, alpha: false } );
	renderer.setSize( window.innerWidth, window.innerHeight );
	renderer.sortObjects = false;
	stage.appendChild( renderer.domElement );

	/*
	var fullScreenButton = document.getElementById( 'fullscreenButton' );
	fullScreenButton.onclick = function() {
		vrEffect.setFullScreen( true );
	};
	*/

	vrEffect = new THREE.VREffect( renderer, VREffectLoaded );
	vrControls = new THREE.VRControls( camera );

	function VREffectLoaded(error) {
		if (error) {
			//fullScreenButton.innerHTML = error;
			//fullScreenButton.classList.add('error');
		}
	}

	window.addEventListener( 'resize', onWindowResize, false );

	onWindowResize()
	animate();

}

function animate() {

	requestAnimationFrame( animate );
	render();
	TWEEN.update();
}
	
function render() {

	vrControls.update();
	vrEffect.render( scene, camera );
	
}

function onWindowResize() {

	renderer.setSize( window.innerWidth, window.innerHeight );
	camera.aspect = window.innerWidth / window.innerHeight;
	camera.updateProjectionMatrix();

	var header = document.getElementById("header")
	header.setAttribute("style","margin-top:"+(window.innerHeight-header.offsetHeight)+"px");
}

window.addEventListener("load", init, false)
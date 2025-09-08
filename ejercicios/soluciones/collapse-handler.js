document.addEventListener('DOMContentLoaded', function() {
  // Función para inicializar los callouts colapsables
  function initCollapsibleCallouts() {
    const solutionCallouts = document.querySelectorAll('.callout-solution');
    
    solutionCallouts.forEach(function(callout) {
      // Buscar el atributo collapse en el callout
      const hasCollapseAttr = callout.innerHTML.includes('collapse="true"');
      
      if (hasCollapseAttr) {
        // Establecer estado inicial como cerrado
        callout.setAttribute('aria-expanded', 'false');
        
        // Buscar el título del callout
        const calloutTitle = callout.querySelector('.callout-title');
        if (calloutTitle) {
          const titleContainer = calloutTitle.parentElement;
          titleContainer.style.cursor = 'pointer';
          titleContainer.style.userSelect = 'none';
          
          // Agregar indicador visual
          if (!titleContainer.querySelector('.collapse-indicator')) {
            const indicator = document.createElement('span');
            indicator.className = 'collapse-indicator';
            indicator.innerHTML = ' ▶';
            indicator.style.transition = 'transform 0.3s ease';
            calloutTitle.appendChild(indicator);
          }
          
          // Agregar evento de click
          titleContainer.addEventListener('click', function() {
            const isExpanded = callout.getAttribute('aria-expanded') === 'true';
            const newState = !isExpanded;
            callout.setAttribute('aria-expanded', newState.toString());
            
            // Actualizar indicador
            const indicator = titleContainer.querySelector('.collapse-indicator');
            if (indicator) {
              indicator.style.transform = newState ? 'rotate(90deg)' : 'rotate(0deg)';
            }
          });
        }
      }
    });
  }
  
  // Inicializar cuando el DOM esté listo
  initCollapsibleCallouts();
  
  // Reinicializar cuando se navegue (para SPAs)
  window.addEventListener('popstate', initCollapsibleCallouts);
  
  // Observer para contenido dinámico
  const observer = new MutationObserver(function(mutations) {
    let shouldReinit = false;
    mutations.forEach(function(mutation) {
      if (mutation.type === 'childList' && mutation.addedNodes.length > 0) {
        for (let node of mutation.addedNodes) {
          if (node.nodeType === 1 && (node.classList.contains('callout-solution') || node.querySelector('.callout-solution'))) {
            shouldReinit = true;
            break;
          }
        }
      }
    });
    
    if (shouldReinit) {
      setTimeout(initCollapsibleCallouts, 100);
    }
  });
  
  observer.observe(document.body, {
    childList: true,
    subtree: true
  });
});

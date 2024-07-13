---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: rabbit-mq
  annotations:
    kubernetes.io/change-cause: 'First Version'
spec:
  minReadySeconds: 10
  replicas: 1
  selector:
    matchLabels:
      app: rabbit-deploy
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
  template:
    metadata:
      labels: 
        app: rabbit-deploy
    spec:
      containers:
        - image: rabbitmq:3-management-alpine
          name: rabbitmq
          resources:
            limits:
              cpu: 250m
              memory: 128Mi
          ports:
            - containerPort: 15672
              protocol: TCP
            - containerPort: 5672
              protocol: TCP
          livenessProbe:
            initialDelaySeconds: 3
            periodSeconds: 5
            successThreshold: 1
            failureThreshold: 2
            httpGet:
              path: '/hc'
              port: 80
          env:
            - name: RABBITMQ_CONFIG_FILE
              value: /etc/pitstop/rabbitmq.conf
          volumeMounts:
            - name: rabbitmqdata
              mountPath: /var/lib/rabbitmq
            - name: rabbitmq
              mountPath: /etc/pitstop/
      volumes:
        - name: rabbitmqdata
          persistentVolumeClaim: 
            claimName: rabbitmq-pvc
        - name: rabbitmq
          persistentVolumeClaim: 
            claimName: rabbitmq-pvc1